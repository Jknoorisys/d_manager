import 'package:d_manager/screens/auth/forgot_password.dart';
import 'package:d_manager/screens/auth/forgot_password_code.dart';
import 'package:d_manager/screens/auth/login.dart';
import 'package:d_manager/screens/auth/set_new_password.dart';
import 'package:d_manager/screens/change_password/change_password.dart';
import 'package:d_manager/screens/dashboard/dashboard.dart';
import 'package:d_manager/screens/manage_cloth_sell/cloth_sell_add.dart';
import 'package:d_manager/screens/manage_cloth_sell/cloth_sell_list.dart';
import 'package:d_manager/screens/manage_cloth_sell/manage_invoice/invoice_add.dart';
import 'package:d_manager/screens/manage_cloth_sell/manage_invoice/invoice_view.dart';
import 'package:d_manager/screens/manage_history/purchase_history.dart';
import 'package:d_manager/screens/manage_history/sell_history.dart';
import 'package:d_manager/screens/manage_masters/manage_cloth_quality/cloth_quality_list.dart';
import 'package:d_manager/screens/manage_masters/manage_firm/firm_add.dart';
import 'package:d_manager/screens/manage_masters/manage_firm/firm_list.dart';
import 'package:d_manager/screens/manage_masters/manage_hammal/hammal_list.dart';
import 'package:d_manager/screens/manage_masters/manage_party/party_add.dart';
import 'package:d_manager/screens/manage_masters/manage_party/party_list.dart';
import 'package:d_manager/screens/manage_masters/manage_transport/transport_list.dart';
import 'package:d_manager/screens/manage_masters/manage_yarn_type/yarn_type_list.dart';
import 'package:d_manager/screens/manage_yarn_purchase/manage_delivery_details/delivery_detail_add.dart';
import 'package:d_manager/screens/manage_yarn_purchase/manage_delivery_details/delivery_detail_view.dart';
import 'package:d_manager/screens/manage_yarn_purchase/yarn_purchase_add.dart';
import 'package:d_manager/screens/manage_yarn_purchase/yarn_purchase_list.dart';
import 'package:d_manager/screens/manage_yarn_purchase/yarn_purchase_view.dart';
import 'package:d_manager/screens/reminders/cloth_sell/payment_to_be_received.dart';
import 'package:d_manager/screens/reminders/cloth_sell/thans_to_be_delivered.dart';
import 'package:d_manager/screens/reminders/yarn_purchase/box_to_be_received.dart';
import 'package:d_manager/screens/reminders/yarn_purchase/payment_due_date.dart';
import 'package:d_manager/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splashScreen = '/';

  // Auth
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String forgotPasswordCode = '/forgot-password-code';
  static const String setNewPassword = '/set-new-password';

  // Dashboard and Change Password
  static const String dashboard = '/dashboard';
  static const String settings = '/settings';

  // Manage My Firm
  static const String firmAdd = '/firm-add';
  static const String firmList = '/firm-list';

  // Manage Party
  static const String partyAdd = '/party-add';
  static const String partyList = '/party-list';

  // Manage Cloth Quality
  static const String clothQualityList = '/cloth-quality-list';

  // Manage Yarn Type
  static const String yarnTypeList = '/yarn-type-list';

  // Manage Transport
  static const String transportList = '/transport-list';

  // Manage Hammal
  static const String hammalList = '/hammal-list';

  // Manage Yarn Purchase
  static const String yarnPurchaseList = '/yarn-purchase-list';
  static const String yarnPurchaseAdd = '/yarn-purchase-add';
  static const String yarnPurchaseView = '/yarn-purchase-view';

  // Manage Delivery Details
  static const String deliveryDetailAdd = '/delivery-detail-add';
  static const String deliveryDetailView = '/delivery-detail-view';

  // Manage Cloth Sell
  static const String clothSellList = '/cloth-sell-list';
  static const String clothSellAdd = '/cloth-sell-add';
  static const String clothSellView = '/cloth-sell-view';

  // Manage Invoices
  static const String invoiceAdd = '/invoice-add';
  static const String invoiceView = '/invoice-view';

  // Reminder screens
  static const String boxToBeReceived = '/box-to-be-received';
  static const String yarnPurchaseViewFromReminder = '/yar-purchase-view-from-reminder';
  static const String paymentDueDate = '/payment-due-date';
  static const String thansToBeDelivered = '/thans-to-be-delivered';
  static const String paymentToBeReceived = '/payment-to-be-received';

  // History
  static const String purchaseHistory = '/purchase-history';
  static const String sellHistory = '/sell-history';


  static final Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    forgotPasswordCode: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final String? emailAddress = args?['emailAddress'];
      return PinCodeVerificationScreen(emailAddress: emailAddress);
    },
    setNewPassword: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final String? email = args?['email'];
      return SetNewPasswordScreen(email: email.toString());
    },
    dashboard: (context) => const DashboardScreen(),
    settings: (context) => const ChangePasswordScreen(),

    // Manage My Firm
    firmList: (context) => const FirmList(),
    firmAdd: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final int? firmId = args?['firmId'];
      return FirmAdd(firmId: firmId);
    },

    // Manage Party
    partyList: (context) => const PartyList(),
    partyAdd: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final int? partyId = args?['partyId'];
      return PartyAdd(partyId: partyId);
    },

    // Manage Cloth Quality
    clothQualityList: (context) => const ClothQualityList(),

    // Manage Yarn Type
    yarnTypeList: (context) => const YarnTypeList(),

    // Manage Transport
    transportList: (context) => const TransportList(),

    // Manage Hammal
    hammalList: (context) => const HammalList(),

    // Manage Yarn Purchase
    yarnPurchaseList: (context) => const YarnPurchaseList(),
    yarnPurchaseAdd: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final Map<String, dynamic>? yarnPurchaseData = args?['yarnPurchaseData'];
      return YarnPurchaseAdd(yarnPurchaseData: yarnPurchaseData);
    },
    yarnPurchaseView: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final Map<String, dynamic>? yarnPurchaseData = args?['yarnPurchaseData'];
      return YarnPurchaseView(yarnPurchaseData: yarnPurchaseData);
    },

    // Manage Delivery Details
    deliveryDetailAdd: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final Map<String, dynamic>? deliveryDetailData = args?['deliveryDetailData'];
      return DeliveryDetailAdd(deliveryDetailData: deliveryDetailData);
    },
    deliveryDetailView: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final Map<String, dynamic>? deliveryDetailData = args?['deliveryDetailData'];
      return DeliveryDetailView(deliveryDetailData: deliveryDetailData);
    },

    // Manage Cloth Sell
    clothSellList: (context) => const ClothSellList(),
    clothSellAdd: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final Map<String, dynamic>? clothSellData = args?['clothSellData'];
      return ClothSellAdd(clothSellData: clothSellData);
    },
    // clothSellView: (context) {
    //   final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    //   final Map<String, dynamic>? clothSellData = args?['clothSellData'];
    //   return ClothSellView();
    //   //clothSellData: clothSellData
    // },


    // Manage Invoices
    invoiceAdd: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final Map<String, dynamic>? invoiceData = args?['invoiceData'];
      return InvoiceAdd(invoiceData: invoiceData);
    },
    invoiceView: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final Map<String, dynamic>? invoiceData = args?['invoiceData'];
      return InvoiceView(invoiceData: invoiceData);
    },

    //Manage Purchase Reminders
    boxToBeReceived: (context) => const BoxToBeReceived(),
    paymentDueDate: (context) => const PaymentDueDate(),

    // Manage Cloth Sell Reminders
    thansToBeDelivered: (context) => const ThansToBeDelivered(),
    paymentToBeReceived: (context) => const PaymentToBeReceived(),

    // Manage History
    purchaseHistory: (context) => const PurchaseHistory(),
    sellHistory: (context) => const SellHistory(),

    yarnPurchaseViewFromReminder: (context) => const YarnPurchaseView(),
  };
}
