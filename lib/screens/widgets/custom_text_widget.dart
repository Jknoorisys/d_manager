import 'package:d_manager/constants/app_theme.dart';
import 'package:flutter/material.dart';

class CustomInfoCard extends StatelessWidget {
  final String title;
  final String content;

  const CustomInfoCard({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppTheme.primary, // You can customize the color here
          ),
        ),
        Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                spreadRadius: 1,
                blurRadius: 2,
                color: Colors.grey.withOpacity(0.5), // You can customize the shadow color here
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(child: Text(content,style: const TextStyle(fontSize: 12),)),
          ),
        ),
      ],
    );
  }
}

// Example usage:
// CustomInfoCard(
// title: "Deal Date",
// content: "15/01/2024",
//)
