import 'package:d_manager/api/auth_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/firebase_services.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/auth_models/login_model.dart';
import 'package:d_manager/models/auth_models/login_with_google_model.dart';
import 'package:d_manager/screens/widgets/animated_logo.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool submitted = false;
  bool isChecked = false;
  bool _obscureText = true;

  bool isLoading = false;
  AuthServices authServices = AuthServices();
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

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

  @override
  Widget build(BuildContext context) {
    var errorPassword = submitted == true ? _validatePassword(passwordController.text) : null,
        errorEmail = submitted == true ? _validateEmail(emailController.text) : null;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
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
                        autoFocus: true,
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
                            setState(() {
                              isLoading = !isLoading;
                            });
                            _login(emailController.text, passwordController.text);
                          }
                        },
                        buttonText: S.of(context).login,
                      ),
                      SizedBox(height: Dimensions.height20),

                      // Login with Google Button
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = !isLoading;
                          });
                          _loginWithGoogle();
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
          ],
        ),
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
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      LoginModel? loginModel = await authServices.login(email, password);
      if (loginModel != null) {
        if (loginModel.success == true) {
          await HelperFunctions.setApiKey(loginModel.data!.apiKey != null ? loginModel.data!.apiKey.toString() : 'NYS03223');
          await HelperFunctions.setUserID(loginModel.data!.userId.toString());
          await HelperFunctions.setUserEmail(loginModel.data!.email.toString());
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
          'Something went wrong, please try again',
          mode: SnackbarMode.error,
        );
        setState(() {
          isLoading = false;
        });
      }
    } else {
      CustomApiSnackbar.show(
        context,
        'Warning',
        'No Internet Connection',
        mode: SnackbarMode.warning,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loginWithGoogle() async {
    if(await HelperFunctions.isPossiblyNetworkAvailable()) {
      firebaseService.signOut();
      final SocialProcess isLoginSuccess = await firebaseService.signInWithGoogle();
      if (isLoginSuccess == SocialProcess.loggedIn) {
        User? user = firebaseService.auth.currentUser;
        print('User: $user');
        if (user != null && user.email != null && user.displayName != null) {
          _callGoogleLoginApi(user.email!, user.uid);
        } else {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
            CustomApiSnackbar.show(
              context,
              'Warning',
              'Google Sign-In Failed',
              mode: SnackbarMode.warning,
            );
          }
        }
      } else if(isLoginSuccess == SocialProcess.error){
        if (mounted) {
          setState(() {
            isLoading = false;
          });
          CustomApiSnackbar.show(
            context,
            'Error',
            'Google Sign-In Error',
            mode: SnackbarMode.error,
          );
        }
      }
    } else {
      setState(() {
        isLoading = false;
      });
      CustomApiSnackbar.show(
        context,
        'Warning',
        'No Internet Connection',
        mode: SnackbarMode.warning,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  void _callGoogleLoginApi(String email, String socialID) async {
    try {
      if (await HelperFunctions.isPossiblyNetworkAvailable()) {
        LoginWithGoogleModel? loginModel = await authServices.loginWithGoogle(email, socialID);
        if (loginModel != null) {
          if (loginModel.success == true) {
            await HelperFunctions.setApiKey(loginModel.data!.apiKey != null ? loginModel.data!.apiKey.toString() : 'NYS03223');
            await HelperFunctions.setUserID(loginModel.data!.userId.toString());
            await HelperFunctions.setUserEmail(loginModel.data!.email.toString());
            await HelperFunctions.setUserName(loginModel.data!.userName.toString());
            await HelperFunctions.setUserImage(loginModel.data!.profilePic.toString() ?? '');
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
      } else {
        CustomApiSnackbar.show(
          context,
          'Warning',
          'No Internet Connection',
          mode: SnackbarMode.warning,
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      CustomApiSnackbar.show(
        context,
        'Error',
        'Something went wrong, please try again',
        mode: SnackbarMode.error,
      );
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

