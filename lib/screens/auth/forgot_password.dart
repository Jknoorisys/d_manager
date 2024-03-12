import 'package:d_manager/api/auth_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/auth_models/forget_password_model.dart';
import 'package:d_manager/screens/widgets/animated_logo.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool submitted = false;
  bool isLoading = false;
  AuthServices authServices = AuthServices();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var errorEmail = submitted == true ? _validateEmail(emailController.text) : null;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: Dimensions.screenHeight,
              decoration: const BoxDecoration(
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

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.width10),
                      child: Text(
                        S.of(context).forgotPassword,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font20),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: Dimensions.width30, vertical: Dimensions.width10),
                      child: RichText(
                        text: TextSpan(
                          text: S.of(context).enterYourEmailAddressToResetYourPassword,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: Dimensions.font14,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(
                      height: Dimensions.height30,
                    ),

                    CustomTextField(
                      controller: emailController,
                      labelText: S.of(context).email,
                      errorText: errorEmail.toString() != 'null' ? errorEmail.toString() : '',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email,
                      borderColor: AppTheme.primary,
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
                            _forgotPassword(emailController.text);
                          }
                        },
                        buttonText: S.of(context).sendCode,
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

  bool _isFormValid() {
    String emailError = _validateEmail(emailController.text) ?? '';

    return emailError.isEmpty;
  }

  Future<void> _forgotPassword(String email) async {
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      ForgetPasswordModel? forgetPasswordModel = await authServices.forgotPassword(email);
      if (forgetPasswordModel.message != null) {
        if (forgetPasswordModel.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            forgetPasswordModel.message.toString(),
            mode: SnackbarMode.success,
          );
          Navigator.of(context).pushNamed(AppRoutes.forgotPasswordCode, arguments: {'emailAddress': email});
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            forgetPasswordModel.message.toString(),
            mode: SnackbarMode.error,
          );
        }
        setState(() {
          isLoading = false;
        });
      } else{
        CustomApiSnackbar.show(
          context,
          'Error',
          'Something went wrong. Please try again later.',
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
}
