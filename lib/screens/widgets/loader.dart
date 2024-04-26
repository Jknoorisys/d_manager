import 'package:d_manager/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: GFLoader(
        type: GFLoaderType.circle,
        loaderColorOne: AppTheme.primary,
        loaderColorTwo: AppTheme.secondary,
        loaderColorThree: AppTheme.secondaryLight,
      ),
    );
  }
}
