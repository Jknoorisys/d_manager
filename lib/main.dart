import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_fonts/google_fonts.dart';
import 'generated/l10n.dart';
import 'helpers/helper_functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HelperFunctions.init();
  initializeDateFormatting('en');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Dimensions.initDimensions(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'D-Manager',
      routes: AppRoutes.routes,
      localizationsDelegates: const [
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('en'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.secondary),
        primaryColor: AppTheme.primary,
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: AppRoutes.splashScreen,
    );
  }
}