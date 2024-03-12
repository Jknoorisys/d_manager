import 'package:d_manager/api/auth_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/auth_models/change_password_model.dart';
import 'package:d_manager/screens/widgets/animated_logo.dart';
import 'package:d_manager/screens/widgets/body.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/drawer/zoom_drawer.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool submitted = false;
  bool _obscureOldPassword = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool isLoading = false;
  AuthServices authServices = AuthServices();

  @override
  void dispose() {
    oldPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var errorOldPassword = submitted == true ? _validateOldPassword(oldPasswordController.text) : null;
    var errorPassword = submitted == true ? _validatePassword(passwordController.text) : null;
    var confirmPasswordError = submitted == true ? _validateConfirmPassword(confirmPasswordController.text) : null;

    return CustomDrawer(
      content: CustomBody(
        isAppBarTitle: false,
        isBackgroundGradient: true,
        isLoading: isLoading,
        content: SingleChildScrollView(
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
                    S.of(context).changePassword,
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

                // Old Password TextField
                CustomTextField(
                  controller: oldPasswordController,
                  isObscure: _obscureOldPassword,
                  labelText: S.of(context).oldPassword,
                  errorText: errorOldPassword.toString() != 'null' ? errorOldPassword.toString() : '',
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: _obscureOldPassword ? Icons.visibility : Icons.visibility_off,
                  borderColor: AppTheme.primary,
                  onTap: (){
                    setState(() {
                      _obscureOldPassword = !_obscureOldPassword;
                    });
                  },
                ),
                SizedBox(height: Dimensions.height20),

                // New Password TextField
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

                // Confirm Password TextField
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
                      setState(() {
                        isLoading = !isLoading;
                      });
                      _changePassword(oldPasswordController.text.trim(), passwordController.text.trim(), confirmPasswordController.text.trim());
                    }
                  },
                  buttonText: S.of(context).changePassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateOldPassword(String value) {
    if (value.isEmpty) {
      return S.of(context).oldPasswordIsRequired;
    }

    if (value.length < 6) {
      return S.of(context).passwordMustBeAtLeast6Characters;
    }
    return null;
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
    String oldPasswordError = _validateOldPassword(oldPasswordController.text) ?? '';

    return passwordError.isEmpty && confirmPasswordError.isEmpty && oldPasswordError.isEmpty;
  }

  Future<void> _changePassword(String oldPassword, String password, String confirmPassword) async {
    if (await HelperFunctions.isPossiblyNetworkAvailable()) {
      ChangePasswordModel? changePasswordModel = await authServices.changePassword(oldPassword, password, confirmPassword);
      if (changePasswordModel.message != null) {
        if (changePasswordModel.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            changePasswordModel.message.toString(),
            mode: SnackbarMode.success,
          );
          HelperFunctions.setLoginStatus(false);
          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
        } else {
          CustomApiSnackbar.show(
            context,
            'Error',
            changePasswordModel.message.toString(),
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
