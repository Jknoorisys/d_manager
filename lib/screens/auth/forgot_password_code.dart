import 'dart:async';
import 'package:d_manager/api/auth_services.dart';
import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:d_manager/generated/l10n.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:d_manager/models/auth_models/forget_password_model.dart';
import 'package:d_manager/models/auth_models/verify_otp_model.dart';
import 'package:d_manager/screens/widgets/animated_logo.dart';
import 'package:d_manager/screens/widgets/buttons.dart';
import 'package:d_manager/screens/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
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
  TextEditingController otpController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  AuthServices authServices = AuthServices();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  snackBar(String? message) {
    return CustomApiSnackbar.show(
      context,
      'Error',
      message.toString(),
      mode: SnackbarMode.error,
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
                          controller: otpController,
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
                        hasError ? S.of(context).invalidOtp : "",
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
                          onPressed: () {
                            setState(() {
                              isLoading = !isLoading;
                            });
                            _resendOtp(widget.emailAddress.toString());
                          },
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
                          if (currentText.length != 4) {
                            errorController!.add(ErrorAnimationType
                                .shake); // Triggering error shake animation
                            setState(() => hasError = true);
                          } else {
                            setState(
                                  () {
                                hasError = false;
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
                                  _verifyOtp(otpController.text, widget.emailAddress.toString());
                                }
                              },
                            );
                          }
                        },
                        buttonText: S.of(context).verify
                    ),

                    // clear and set buttons
                    // SizedBox(
                    //   height: Dimensions.height10,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Flexible(
                    //       child: TextButton(
                    //         child: Text(S.of(context).clear),
                    //         onPressed: () {
                    //           otpController.clear();
                    //         },
                    //       ),
                    //     ),
                    //     Flexible(
                    //       child: TextButton(
                    //         child: Text(S.of(context).setText),
                    //         onPressed: () {
                    //           setState(() {
                    //             otpController.text = "4130";
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // )
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

  Future<void> _verifyOtp(String otp, String email) async {
    VerifyOtpModel verifyOtpModel = await authServices.verifyOtp(email, otp);
    if (verifyOtpModel != null) {
      if (verifyOtpModel.success == true && verifyOtpModel.otpVerified == "1") {
        CustomApiSnackbar.show(
          context,
          'Success',
          verifyOtpModel.message.toString(),
          mode: SnackbarMode.success,
        );
        Navigator.pushReplacementNamed(context, AppRoutes.setNewPassword, arguments: {'email': email});
      } else {
        CustomApiSnackbar.show(
          context,
          'Error',
          verifyOtpModel!.message.toString(),
          mode: SnackbarMode.error,
        );
        setState(() {
          isLoading = false;
        });
      }
    } else {
      CustomApiSnackbar.show(
        context,
        'Error',
        verifyOtpModel!.message.toString(),
        mode: SnackbarMode.error,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _resendOtp(String email) async {
    if(await HelperFunctions.isPossiblyNetworkAvailable()) {
      ForgetPasswordModel forgetPasswordModel = await authServices.forgotPassword(email);
      if (forgetPasswordModel.message != null) {
        if (forgetPasswordModel.success == true) {
          CustomApiSnackbar.show(
            context,
            'Success',
            forgetPasswordModel.message.toString(),
            mode: SnackbarMode.success,
          );
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
}

