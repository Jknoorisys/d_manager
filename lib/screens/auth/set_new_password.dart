import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/animated_logo.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool submitted = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    var errorPassword = submitted == true ? _validatePassword(passwordController.text) : null;
    var confirmPasswordError = submitted == true ? _validateConfirmPassword(confirmPasswordController.text) : null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                      Navigator.of(context).pushNamed(AppRoutes.login);
                    }
                  },
                  buttonText: S.of(context).resetPassword,
                ),
              ],
            ),
          ),
        ),
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
}
