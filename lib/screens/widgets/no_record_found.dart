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
            textAlign: TextAlign.center, // Center the text
          ),
        ),
      ],
    );
    // return FutureBuilder<bool>(
    //   future: checkNetwork(),
    //   builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Container();
    //     } else if (snapshot.hasError) {
    //       return Text('Error: ${snapshot.error}');
    //     } else {
    //       bool isNetworkAvailable = snapshot.data ?? false;
    //       if (isNetworkAvailable) {
    //         return Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Center(
    //               child: Container(
    //                 // padding: EdgeInsets.all(20),
    //                 margin: const EdgeInsets.all(10),
    //                 // decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
    //                 child: icon is String
    //                     ? Image.asset(icon, width: 60, height: 60)
    //                     : Icon(icon ?? Icons.info_outlined, size: 60),
    //               ),
    //             ),
    //             Text(msg ?? 'No Record Found',
    //                 style: AppTheme.body2,)
    //           ],
    //         );
    //       } else {
    //         return Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Container( // Icon Container
    //               padding: const EdgeInsets.all(20.0),
    //               decoration: BoxDecoration(
    //                 color: AppTheme.primary.withOpacity(0.1), // Light background
    //                 shape: BoxShape.circle,
    //               ),
    //               child: const Icon(Icons.wifi_off, color: AppTheme.primary, size: 50),
    //             ),
    //             const SizedBox(height: 15), // Spacing between icon and text
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 15.0),
    //               child: RichText(
    //                 textAlign: TextAlign.center, // Center the text
    //                 text: TextSpan(
    //                   style: AppTheme.body2,
    //                   children: [
    //                     TextSpan(
    //                         text: 'Oops! No Internet Connection\n',
    //                         style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
    //                     TextSpan(
    //                         text:
    //                         'It looks like you\'re not connected to the internet. Please check your Wi-Fi or mobile data settings.',
    //                         style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         );
    //       }
    //     }
    //   },
    // );
  }
}
