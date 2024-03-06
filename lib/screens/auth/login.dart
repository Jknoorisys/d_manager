import 'dart:convert';

import 'package:d_manager/api/auth_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/firebase_services.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/auth_models/login_model.dart';
import 'package:d_manager/screens/widgets/animated_logo.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../helpers/auth_interface.dart';
import '../../helpers/fcm_services.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool submitted = false;
  bool isLoggedIn = false;
  bool isChecked = false;
  bool _obscureText = true;

  bool isLoading = false;
  bool _googleLoading = false;
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    _loadStoredCredentials();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _loadStoredCredentials() async {
    Map<String, String> storedCredentials = await HelperFunctions.getStoredCredentials();
    setState(() {
      emailController.text = storedCredentials['email'] ?? '';
      passwordController.text = storedCredentials['password'] ?? '';
    });
  }

  // _loadGoogleStoredCredential() async {
  //   Map<String, String> storedCredentials = await HelperFunctions.getGoogleCredentials();
  //   if (storedCredentials.containsKey('gmail')) {
  //     setState(() {
  //       isLoggedIn = true;
  //     });
  //     Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
  //     } else {
  //       print("Something went wrong");
  //     }
  // }



  @override
  Widget build(BuildContext context) {
    var errorPassword = submitted == true ? _validatePassword(passwordController.text) : null,
        errorEmail = submitted == true ? _validateEmail(emailController.text) : null;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: Dimensions.screenHeight,
              decoration:  const BoxDecoration(
                gradient: AppTheme.appGradientLight,
              ),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.width25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo or Header
                    const AnimatedLogo(),
                    SizedBox(height: Dimensions.height20),
                    // Email TextField
                    CustomTextField(
                      controller: emailController,
                      labelText: S.of(context).email,
                      errorText: errorEmail.toString() != 'null' ? errorEmail.toString() : '',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email,
                      borderColor: AppTheme.primary,
                    ),
                    SizedBox(height: Dimensions.height20),

                    // Password TextField
                    CustomTextField(
                      controller: passwordController,
                      isObscure: _obscureText,
                      labelText: S.of(context).password,
                      errorText: errorPassword.toString() != 'null' ? errorPassword.toString() : '',
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: _obscureText ? Icons.visibility : Icons.visibility_off,
                      prefixIcon: Icons.lock,
                      borderColor: AppTheme.primary,
                      onSuffixTap: (){
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    SizedBox(height: Dimensions.height20),

                    // Forget Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Remember Me Checkbox
                        Row(
                          children: [
                            GFCheckbox(
                              size: Dimensions.height20,
                              type: GFCheckboxType.custom,
                              inactiveBgColor: Colors.white,
                              inactiveBorderColor: AppTheme.primary,
                              activeBorderColor: AppTheme.primary,
                              customBgColor: AppTheme.primary,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value;
                                });
                              },
                              value: isChecked,
                              inactiveIcon: null,
                            ),
                            Text(S.of(context).rememberMe, style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                          ],
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.forgotPassword);
                          },
                          child: Text(
                            S.of(context).forgetPassword,
                            style: const TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.height20),
                    // Login Button
                    CustomElevatedButton(
                      onPressed: () {
                        setState(() {
                          submitted = true;
                        });
                        if (_isFormValid()) {
                          if (HelperFunctions.checkInternet() == false) {
                            CustomApiSnackbar.show(
                              context,
                              'Warning',
                              'No internet connection',
                              mode: SnackbarMode.warning,
                            );
                          } else {
                            setState(() {
                              isLoading = !isLoading;
                            });
                            _login(emailController.text, passwordController.text);
                          }
                        }
                      },
                      buttonText: S.of(context).login,
                    ),
                    SizedBox(height: Dimensions.height20),

                    // Login with Google Button
                    OutlinedButton(
                      onPressed: () {
                        // Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
                        setState(() {
                          _googleLoading = !_googleLoading;
                        });
                        callGoogleLoginAPI();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.primary),
                        padding: EdgeInsets.symmetric(vertical: Dimensions.height15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.google,
                            color: AppTheme.primary,
                            size: Dimensions.font26,
                          ),
                          SizedBox(width: Dimensions.height10),
                          Text(
                            S.of(context).loginWithGoogle,
                            style: TextStyle(
                              fontSize: Dimensions.font16,
                              color: AppTheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: GFLoader(
                  type: GFLoaderType.circle,
                  loaderColorOne: AppTheme.primary,
                  loaderColorTwo: AppTheme.secondary,
                  loaderColorThree: AppTheme.secondaryLight,
                ),
              ),
            ),
          if (_googleLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: GFLoader(
                  type: GFLoaderType.circle,
                  loaderColorOne: AppTheme.primary,
                  loaderColorTwo: AppTheme.secondary,
                  loaderColorThree: AppTheme.secondaryLight,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return S.of(context).emailIsRequired;
    }

    if (!GetUtils.isEmail(value)) {
      return S.of(context).invalidEmail;
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return S.of(context).passwordIsRequired;
    }

    if (value.length < 3) {
      return S.of(context).passwordMustBeAtLeast6Characters;
    }
    return null;
  }

  bool _isFormValid() {
    String emailError = _validateEmail(emailController.text) ?? '';
    String passwordError = _validatePassword(passwordController.text) ?? '';
    return emailError.isEmpty && passwordError.isEmpty;
  }

  Future<void> _login(String email, String password) async {
    LoginModel? loginModel = await authServices.login(email, password);
    if (loginModel != null) {
      if (loginModel.success == true) {
        await HelperFunctions.setApiKey(loginModel.data!.apiKey != null ? loginModel.data!.apiKey.toString() : 'NYS03223');
        await HelperFunctions.setUserID(loginModel.data!.userId.toString());
        await HelperFunctions.setUserEmail(loginModel.data!.userEmail.toString());
        await HelperFunctions.setUserName(loginModel.data!.userName.toString());
        await HelperFunctions.setUserImage(loginModel.data!.profilePic.toString());
        await HelperFunctions.setLoginStatus(true);
        if (isChecked == true) {
          HelperFunctions.saveCredentials(emailController.text, passwordController.text);
        } else{
          HelperFunctions.saveCredentials('', '');
        }
        Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
      }  else {
        CustomApiSnackbar.show(
          context,
          'Error',
          loginModel.message.toString(),
          mode: SnackbarMode.error,
        );
      }
      setState(() {
        isLoading = false;
      });
    } else {
      CustomApiSnackbar.show(
        context,
        'Error',
        loginModel!.message.toString(),
        mode: SnackbarMode.error,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  callGoogleLoginAPI() async {
    setState(() {
      _googleLoading = true; // Show loader when the button is tapped
    });
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final String uid = googleUser.id;
        final String email = googleUser.email ?? '';
        // if (isLoggedIn) {
        //   HelperFunctions.saveGoogleCredentials(email, uid);
        // }
        Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
        print('Google Sign-In Successful:');
        print('UID: $uid');
        print('Email: $email');
      } else {
        CustomApiSnackbar.show(
          context,
          'Warning',
          'Google Sign-In Canceled',
          mode: SnackbarMode.warning,
        );
      }
    } catch (e) {
      CustomApiSnackbar.show(
        context,
        'Error',
        'Google Sign-In Error',
        mode: SnackbarMode.error,
      );
    }
    finally {
      setState(() {
        _googleLoading = false; // Hide loader after the process is completed
      });
    }
  }
}

