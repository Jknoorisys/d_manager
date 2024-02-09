import 'package:d_manager/constants/app_theme.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final Widget body;
  final String message;

  const CustomLoader({
    required this.body,
    this.message = "Loading... Please wait",
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        body,
        Container(
          alignment: Alignment.center,
          color: Colors.white70,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.secondaryLight,
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: 250.0,
            height: 200.0,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: CircularProgressIndicator(
                      value: null,
                      strokeWidth: 7.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
