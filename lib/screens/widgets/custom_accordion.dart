import 'package:d_manager/constants/app_theme.dart';
import 'package:d_manager/constants/dimension.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

class CustomAccordion extends StatelessWidget {
  final Widget titleChild;
  final Widget contentChild;

  const CustomAccordion({
    Key? key,
    required this.titleChild,
    required this.contentChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: AppTheme.white,
          elevation: 5,
          surfaceTintColor: AppTheme.white,
          shadowColor: AppTheme.grey.withOpacity(0.2),
          child:
          GFAccordion(
            expandedTitleBackgroundColor: AppTheme.white,
            contentBackgroundColor: AppTheme.white,
            collapsedIcon: Container(
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                border: Border.all(color: AppTheme.primary, width: 1),
              ),
              child: const Icon(Icons.keyboard_arrow_down, color: AppTheme.nearlyBlack)
            ),
            expandedIcon: Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  border: Border.all(color: AppTheme.primary, width: 1),
                ),
                child: const Icon(Icons.keyboard_arrow_up, color: AppTheme.nearlyBlack)
            ),
            titlePadding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10/2),
            contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10/2),
            titleChild: titleChild,
            contentChild: contentChild,
          ),
        ),
        SizedBox(height: Dimensions.height10),
      ],
    );
  }
}

class CustomAccordionWithoutExpanded extends StatelessWidget {
  final Widget titleChild;
  final Widget contentChild;

  const CustomAccordionWithoutExpanded({
    Key? key,
    required this.titleChild,
    required this.contentChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.white,
      elevation: 5,
      surfaceTintColor: AppTheme.white,
      shadowColor: AppTheme.grey.withOpacity(0.2),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.height15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleChild, // Title child
            SizedBox(height: Dimensions.height10),
            contentChild, // Content child
          ],
        ),
      ),
    );
  }
}

