import 'dart:async';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/screens/widgets/animated_logo.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class PinCodeVerificationScreen extends StatefulWidget {
  const PinCodeVerificationScreen({
    super.key,
    this.emailAddress,
  });

  final String? emailAddress;
  @override
  State<PinCodeVerificationScreen> createState() => _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

                // verification text
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.width10),
                  child: Text(
                    S.of(context).emailVerification,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font20),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: Dimensions.width30, vertical: Dimensions.width10),
                  child: RichText(
                    text: TextSpan(
                      text: S.of(context).enterTheCodeSentTo,
                      children: [
                        TextSpan(
                          text: " ${widget.emailAddress ?? "xyz@gmail.com"}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font14,
                          ),
                        ),
                      ],
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: Dimensions.font14,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),

                // fields for OTP
                Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.width10,
                      horizontal: Dimensions.width30,
                    ),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: const TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: false,
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 4) {
                          return S.of(context).codeShouldBe4DigitsLong;
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        errorBorderWidth: 1,
                        inactiveBorderWidth: 1,
                        activeBorderWidth: 1,
                        selectedBorderWidth: 1,
                        shape: PinCodeFieldShape.box,
                        activeColor: AppTheme.primary,
                        selectedColor: AppTheme.primary,
                        selectedFillColor: Colors.white,
                        inactiveColor: Colors.grey,
                        inactiveFillColor: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: Dimensions.height60,
                        fieldWidth: Dimensions.height60,
                        activeFillColor: AppTheme.secondaryLight,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: false,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint(S.of(context).completed);
                      },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint(S.of(context).allowingToPasteText);
                        return true;
                      },
                    ),
                  ),
                ),

                // validation OTP
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
                  child: Text(
                    hasError ? S.of(context).pleaseFillUpAllTheCellsProperly : "",
                    style: TextStyle(
                      color: Colors.red.shade800,
                      fontSize: Dimensions.font14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                // resend OTP
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).didntReceiveTheCode,
                      style: TextStyle(color: Colors.black54, fontSize: Dimensions.font14),
                    ),
                    TextButton(
                      onPressed: () => snackBar(S.of(context).otpResend),
                      child: Text(
                        S.of(context).resend,
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.font16,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),

                // verify button
                CustomElevatedButton(
                    onPressed: () {
                      formKey.currentState!.validate();
                      // conditions for validating
                      if (currentText.length != 4 || currentText != "4130") {
                        errorController!.add(ErrorAnimationType
                            .shake); // Triggering error shake animation
                        setState(() => hasError = true);
                      } else {
                        setState(
                              () {
                            hasError = false;
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.setNewPassword,
                            );
                          },
                        );
                      }
                    },
                    buttonText: S.of(context).verify
                ),

                // clear and set buttons
                SizedBox(
                  height: Dimensions.height10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: TextButton(
                        child: Text(S.of(context).clear),
                        onPressed: () {
                          textEditingController.clear();
                        },
                      ),
                    ),
                    Flexible(
                      child: TextButton(
                        child: Text(S.of(context).setText),
                        onPressed: () {
                          setState(() {
                            textEditingController.text = "4130";
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

