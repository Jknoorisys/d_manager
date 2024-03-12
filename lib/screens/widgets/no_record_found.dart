import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class NoRecordFound extends StatelessWidget {
  const NoRecordFound(
      {Key? key, this.icon, this.bgColor = AppTheme.secondary, this.msg})
      : super(key: key);
  final dynamic icon;
  final Color bgColor;
  final String? msg;

  // Future<bool> checkNetwork() async {
  //   var network = await HelperFunctions.isPossiblyNetworkAvailable();
  //   return network;
  // }

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container( // Icon Container
          padding: EdgeInsets.all(Dimensions.height20),
          decoration: BoxDecoration(
            color: AppTheme.secondary.withOpacity(0.1), // Light background
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.info_rounded, color: AppTheme.primary, size: Dimensions.height60),
        ),
        const SizedBox(height: 15), // Spacing between icon and text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            'No Record Found',
            style: AppTheme.body2.copyWith(fontWeight: FontWeight.w700, fontSize: Dimensions.font18, color: AppTheme.primary),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
