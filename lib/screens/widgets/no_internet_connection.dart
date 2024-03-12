import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:flutter/material.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container( // Icon Container
            padding: EdgeInsets.all(Dimensions.height20),
            decoration: BoxDecoration(
              color: AppTheme.secondary.withOpacity(0.1), // Light background
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.wifi_off, color: AppTheme.primary, size: Dimensions.height60),
          ),
          const SizedBox(height: 15), // Spacing between icon and text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: RichText(
              textAlign: TextAlign.center, // Center the text
              text: TextSpan(
                style: AppTheme.body2,
                children: [
                  TextSpan(
                      text: 'Oops! No Internet Connection\n',
                    style: AppTheme.body2.copyWith(fontWeight: FontWeight.w700, fontSize: Dimensions.font18, color: AppTheme.primary)),
                  TextSpan(
                      text:
                      'It looks like you\'re not connected to the internet. Please check your Wi-Fi or mobile data settings.',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: AppTheme.deactivatedText)),
                ],
              ),
            ),
          ),
        ],
      );
  }
}
