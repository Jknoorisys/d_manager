import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/animated_logo.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:getwidget/getwidget.dart';
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

  @override
  Widget build(BuildContext context) {
    var errorPassword = submitted == true ? _validatePassword(passwordController.text) : null,
        errorEmail = submitted == true ? _validateEmail(emailController.text) : null;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                  prefixIcon: _obscureText ? Icons.visibility : Icons.visibility_off,
                  borderColor: AppTheme.primary,
                  onTap: (){
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
                      Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
                    }
                  },
                  buttonText: S.of(context).login,
                ),
                SizedBox(height: Dimensions.height20),

                // Login with Google Button
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
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

    if (value.length < 6) {
      return S.of(context).passwordMustBeAtLeast6Characters;
    }
    return null;
  }

  bool _isFormValid() {
    String emailError = _validateEmail(emailController.text) ?? '';
    String passwordError = _validatePassword(passwordController.text) ?? '';

    return emailError.isEmpty && passwordError.isEmpty;
  }
}

