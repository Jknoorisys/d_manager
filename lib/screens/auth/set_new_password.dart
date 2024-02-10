import 'package:d_manager/api/auth_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/reset_password_model.dart';
import 'package:d_manager/screens/widgets/animated_logo.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';

class SetNewPasswordScreen extends StatefulWidget {
  final String email;
  const SetNewPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool submitted = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool isLoading = false;
  AuthServices authServices = AuthServices();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var errorPassword = submitted == true ? _validatePassword(passwordController.text) : null;
    var confirmPasswordError = submitted == true ? _validateConfirmPassword(confirmPasswordController.text) : null;

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
                        S.of(context).resetPassword,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font20),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: Dimensions.width30, vertical: Dimensions.width10),
                      child: RichText(
                        text: TextSpan(
                          text: S.of(context).setNewPasswordForYourAccount,
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
                      controller: passwordController,
                      isObscure: _obscurePassword,
                      labelText: S.of(context).newPassword,
                      errorText: errorPassword.toString() != 'null' ? errorPassword.toString() : '',
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      borderColor: AppTheme.primary,
                      onTap: (){
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    SizedBox(height: Dimensions.height20),

                    CustomTextField(
                      controller: confirmPasswordController,
                      isObscure: _obscureConfirmPassword,
                      labelText: S.of(context).confirmPassword,
                      errorText: confirmPasswordError.toString() != 'null' ? confirmPasswordError.toString() : '',
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                      borderColor: AppTheme.primary,
                      onTap: (){
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    SizedBox(height: Dimensions.height20),

                    // Button
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
                            _resetPassword(widget.email, passwordController.text, confirmPasswordController.text);
                          }
                        }
                      },
                      buttonText: S.of(context).resetPassword,
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

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return S.of(context).passwordIsRequired;
    }

    if (value.length < 6) {
      return S.of(context).passwordMustBeAtLeast6Characters;
    }
    return null;
  }

  String? _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return S.of(context).confirmPasswordIsRequired;
    }

    if (value.length < 6) {
      return S.of(context).confirmPasswordMustBeAtLeast6Characters;
    }

    if (value != passwordController.text) {
      return S.of(context).passwordDoesNotMatch;
    }
    return null;
  }

  bool _isFormValid() {
    String confirmPasswordError = _validateConfirmPassword(confirmPasswordController.text) ?? '';
    String passwordError = _validatePassword(passwordController.text) ?? '';

    return passwordError.isEmpty && confirmPasswordError.isEmpty;
  }

  Future<void> _resetPassword(String email, String password, String confirmPassword) async {
    ResetPasswordModel? resetPasswordModel = await authServices.resetPassword(email, password, confirmPassword);
    if (resetPasswordModel.message != null && resetPasswordModel.status != null) {
      if (resetPasswordModel.status == 'success') {
        CustomApiSnackbar.show(
          context,
          'Success',
          resetPasswordModel.message.toString(),
          mode: SnackbarMode.success,
        );
        Navigator.of(context).pushNamed(AppRoutes.login);
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          resetPasswordModel.message.toString(),
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
        'Something went wrong, please try again',
        mode: SnackbarMode.error,
      );
      setState(() {
        isLoading = false;
      });
    }
  }
}
