// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login with Google`
  String get loginWithGoogle {
    return Intl.message(
      'Login with Google',
      name: 'loginWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get rememberMe {
    return Intl.message(
      'Remember Me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgetPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address to reset your password.`
  String get enterYourEmailAddressToResetYourPassword {
    return Intl.message(
      'Enter your email address to reset your password.',
      name: 'enterYourEmailAddressToResetYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message(
      'Send Code',
      name: 'sendCode',
      desc: '',
      args: [],
    );
  }

  /// `Email Verification`
  String get emailVerification {
    return Intl.message(
      'Email Verification',
      name: 'emailVerification',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code sent to`
  String get enterTheCodeSentTo {
    return Intl.message(
      'Enter the code sent to',
      name: 'enterTheCodeSentTo',
      desc: '',
      args: [],
    );
  }

  /// `Code should be 4 digits long`
  String get codeShouldBe4DigitsLong {
    return Intl.message(
      'Code should be 4 digits long',
      name: 'codeShouldBe4DigitsLong',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Allowing to paste $text`
  String get allowingToPasteText {
    return Intl.message(
      'Allowing to paste \$text',
      name: 'allowingToPasteText',
      desc: '',
      args: [],
    );
  }

  /// `*Please fill up all the cells properly`
  String get pleaseFillUpAllTheCellsProperly {
    return Intl.message(
      '*Please fill up all the cells properly',
      name: 'pleaseFillUpAllTheCellsProperly',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive the code?`
  String get didntReceiveTheCode {
    return Intl.message(
      'Didn\'t receive the code?',
      name: 'didntReceiveTheCode',
      desc: '',
      args: [],
    );
  }

  /// `OTP resend!!`
  String get otpResend {
    return Intl.message(
      'OTP resend!!',
      name: 'otpResend',
      desc: '',
      args: [],
    );
  }

  /// `RESEND`
  String get resend {
    return Intl.message(
      'RESEND',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `VERIFY`
  String get verify {
    return Intl.message(
      'VERIFY',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Set Text`
  String get setText {
    return Intl.message(
      'Set Text',
      name: 'setText',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Set new password for your account`
  String get setNewPasswordForYourAccount {
    return Intl.message(
      'Set new password for your account',
      name: 'setNewPasswordForYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordIsRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordMustBeAtLeast6Characters {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordMustBeAtLeast6Characters',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password is required`
  String get confirmPasswordIsRequired {
    return Intl.message(
      'Confirm Password is required',
      name: 'confirmPasswordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password must be at least 6 characters`
  String get confirmPasswordMustBeAtLeast6Characters {
    return Intl.message(
      'Confirm Password must be at least 6 characters',
      name: 'confirmPasswordMustBeAtLeast6Characters',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get passwordDoesNotMatch {
    return Intl.message(
      'Password does not match',
      name: 'passwordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailIsRequired {
    return Intl.message(
      'Email is required',
      name: 'emailIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email`
  String get invalidEmail {
    return Intl.message(
      'Invalid Email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Old password is required`
  String get oldPasswordIsRequired {
    return Intl.message(
      'Old password is required',
      name: 'oldPasswordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Manage \nMasters`
  String get manageNmasters {
    return Intl.message(
      'Manage \nMasters',
      name: 'manageNmasters',
      desc: '',
      args: [],
    );
  }

  /// `My Firm`
  String get myFirm {
    return Intl.message(
      'My Firm',
      name: 'myFirm',
      desc: '',
      args: [],
    );
  }

  /// `Party`
  String get party {
    return Intl.message(
      'Party',
      name: 'party',
      desc: '',
      args: [],
    );
  }

  /// `Cloth Quality`
  String get clothQuality {
    return Intl.message(
      'Cloth Quality',
      name: 'clothQuality',
      desc: '',
      args: [],
    );
  }

  /// `Yarn Type`
  String get yarnType {
    return Intl.message(
      'Yarn Type',
      name: 'yarnType',
      desc: '',
      args: [],
    );
  }

  /// `Transport`
  String get transport {
    return Intl.message(
      'Transport',
      name: 'transport',
      desc: '',
      args: [],
    );
  }

  /// `Hammal`
  String get hammal {
    return Intl.message(
      'Hammal',
      name: 'hammal',
      desc: '',
      args: [],
    );
  }

  /// `Manage Yarn Purchase Deal`
  String get manageYarnPurchaseDeal {
    return Intl.message(
      'Manage Yarn Purchase Deal',
      name: 'manageYarnPurchaseDeal',
      desc: '',
      args: [],
    );
  }

  /// `Manage Masters`
  String get manageMasters {
    return Intl.message(
      'Manage Masters',
      name: 'manageMasters',
      desc: '',
      args: [],
    );
  }

  /// `Manage Cloth Sell Deal`
  String get manageClothSellDeal {
    return Intl.message(
      'Manage Cloth Sell Deal',
      name: 'manageClothSellDeal',
      desc: '',
      args: [],
    );
  }

  /// `Reminders`
  String get reminders {
    return Intl.message(
      'Reminders',
      name: 'reminders',
      desc: '',
      args: [],
    );
  }

  /// `Yarn Purchase`
  String get yarnPurchase {
    return Intl.message(
      'Yarn Purchase',
      name: 'yarnPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Box to be Received`
  String get boxToBeReceived {
    return Intl.message(
      'Box to be Received',
      name: 'boxToBeReceived',
      desc: '',
      args: [],
    );
  }

  /// `Payment Due Date`
  String get paymentDueDate {
    return Intl.message(
      'Payment Due Date',
      name: 'paymentDueDate',
      desc: '',
      args: [],
    );
  }

  /// `Cloth Sell`
  String get clothSell {
    return Intl.message(
      'Cloth Sell',
      name: 'clothSell',
      desc: '',
      args: [],
    );
  }

  /// `Thans to be Delivered`
  String get thansToBeDelivered {
    return Intl.message(
      'Thans to be Delivered',
      name: 'thansToBeDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Payment to be Received`
  String get paymentToBeReceived {
    return Intl.message(
      'Payment to be Received',
      name: 'paymentToBeReceived',
      desc: '',
      args: [],
    );
  }

  /// `Manage History`
  String get manageHistory {
    return Intl.message(
      'Manage History',
      name: 'manageHistory',
      desc: '',
      args: [],
    );
  }

  /// `Purchase History`
  String get purchaseHistory {
    return Intl.message(
      'Purchase History',
      name: 'purchaseHistory',
      desc: '',
      args: [],
    );
  }

  /// `Sell History`
  String get sellHistory {
    return Intl.message(
      'Sell History',
      name: 'sellHistory',
      desc: '',
      args: [],
    );
  }

  /// `Purchases`
  String get purchases {
    return Intl.message(
      'Purchases',
      name: 'purchases',
      desc: '',
      args: [],
    );
  }

  /// `Cloth Sells`
  String get clothSells {
    return Intl.message(
      'Cloth Sells',
      name: 'clothSells',
      desc: '',
      args: [],
    );
  }

  /// `Firm List`
  String get firmList {
    return Intl.message(
      'Firm List',
      name: 'firmList',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Party List`
  String get partyList {
    return Intl.message(
      'Party List',
      name: 'partyList',
      desc: '',
      args: [],
    );
  }

  /// `Search Party`
  String get searchParty {
    return Intl.message(
      'Search Party',
      name: 'searchParty',
      desc: '',
      args: [],
    );
  }

  /// `Search Firm`
  String get searchFirm {
    return Intl.message(
      'Search Firm',
      name: 'searchFirm',
      desc: '',
      args: [],
    );
  }

  /// `Cloth Quality List`
  String get clothQualityList {
    return Intl.message(
      'Cloth Quality List',
      name: 'clothQualityList',
      desc: '',
      args: [],
    );
  }

  /// `Search Cloth Quality`
  String get searchClothQuality {
    return Intl.message(
      'Search Cloth Quality',
      name: 'searchClothQuality',
      desc: '',
      args: [],
    );
  }

  /// `Add Cloth Quality`
  String get addClothQuality {
    return Intl.message(
      'Add Cloth Quality',
      name: 'addClothQuality',
      desc: '',
      args: [],
    );
  }

  /// `Yarn Type List`
  String get yarnTypeList {
    return Intl.message(
      'Yarn Type List',
      name: 'yarnTypeList',
      desc: '',
      args: [],
    );
  }

  /// `Search Yarn Type`
  String get searchYarnType {
    return Intl.message(
      'Search Yarn Type',
      name: 'searchYarnType',
      desc: '',
      args: [],
    );
  }

  /// `Add Yarn Type`
  String get addYarnType {
    return Intl.message(
      'Add Yarn Type',
      name: 'addYarnType',
      desc: '',
      args: [],
    );
  }

  /// `Transport List`
  String get transportList {
    return Intl.message(
      'Transport List',
      name: 'transportList',
      desc: '',
      args: [],
    );
  }

  /// `Add Transport`
  String get addTransport {
    return Intl.message(
      'Add Transport',
      name: 'addTransport',
      desc: '',
      args: [],
    );
  }

  /// `Hammal List`
  String get hammalList {
    return Intl.message(
      'Hammal List',
      name: 'hammalList',
      desc: '',
      args: [],
    );
  }

  /// `Search Transport`
  String get searchTransport {
    return Intl.message(
      'Search Transport',
      name: 'searchTransport',
      desc: '',
      args: [],
    );
  }

  /// `Search Hammal`
  String get searchHammal {
    return Intl.message(
      'Search Hammal',
      name: 'searchHammal',
      desc: '',
      args: [],
    );
  }

  /// `Add Hammal`
  String get addHammal {
    return Intl.message(
      'Add Hammal',
      name: 'addHammal',
      desc: '',
      args: [],
    );
  }

  /// `Add Firm`
  String get addFirm {
    return Intl.message(
      'Add Firm',
      name: 'addFirm',
      desc: '',
      args: [],
    );
  }

  /// `Add Party`
  String get addParty {
    return Intl.message(
      'Add Party',
      name: 'addParty',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message(
      'Select Date',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `Total Purchase Amount`
  String get totalPurchaseAmount {
    return Intl.message(
      'Total Purchase Amount',
      name: 'totalPurchaseAmount',
      desc: '',
      args: [],
    );
  }

  /// `Yarn Purchases List`
  String get yarnPurchasesList {
    return Intl.message(
      'Yarn Purchases List',
      name: 'yarnPurchasesList',
      desc: '',
      args: [],
    );
  }

  /// `Cloth Sell List`
  String get clothSellList {
    return Intl.message(
      'Cloth Sell List',
      name: 'clothSellList',
      desc: '',
      args: [],
    );
  }

  /// `Edit Firm`
  String get editFirm {
    return Intl.message(
      'Edit Firm',
      name: 'editFirm',
      desc: '',
      args: [],
    );
  }

  /// `Yarn Purchase Deal Details`
  String get yarnPurchaseDealDetails {
    return Intl.message(
      'Yarn Purchase Deal Details',
      name: 'yarnPurchaseDealDetails',
      desc: '',
      args: [],
    );
  }

  /// `Search Delivery Details`
  String get searchDeliveryDetails {
    return Intl.message(
      'Search Delivery Details',
      name: 'searchDeliveryDetails',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Detail`
  String get deliveryDetail {
    return Intl.message(
      'Delivery Detail',
      name: 'deliveryDetail',
      desc: '',
      args: [],
    );
  }

  /// `Add Transport Detail`
  String get addTransportDetail {
    return Intl.message(
      'Add Transport Detail',
      name: 'addTransportDetail',
      desc: '',
      args: [],
    );
  }

  /// `Cloth Sell Deal Details`
  String get clothSellDealDetails {
    return Intl.message(
      'Cloth Sell Deal Details',
      name: 'clothSellDealDetails',
      desc: '',
      args: [],
    );
  }

  /// `Invalid OTP`
  String get invalidOtp {
    return Intl.message(
      'Invalid OTP',
      name: 'invalidOtp',
      desc: '',
      args: [],
    );
  }

  /// `Cloth Sell Deal`
  String get clothSellDeal {
    return Intl.message(
      'Cloth Sell Deal',
      name: 'clothSellDeal',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Masters`
  String get masters {
    return Intl.message(
      'Masters',
      name: 'masters',
      desc: '',
      args: [],
    );
  }

  /// `Yarn Purchase Deal`
  String get yarnPurchaseDeal {
    return Intl.message(
      'Yarn Purchase Deal',
      name: 'yarnPurchaseDeal',
      desc: '',
      args: [],
    );
  }

  /// `Return GST Amount`
  String get returnGstAmount {
    return Intl.message(
      'Return GST Amount',
      name: 'returnGstAmount',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
