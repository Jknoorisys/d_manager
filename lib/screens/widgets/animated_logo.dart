import 'package:d_manager/constants/dimension.dart';
import 'package:d_manager/constants/images.dart';
import 'package:flutter/material.dart';

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({Key? key}) : super(key: key);

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Add a listener to reverse the animation when it completes
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
    });

    // Start the animation when the widget is built
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height50 * 3,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(controller.value * 3.141), // Flip animation
            child: Image.asset(AppImages.appLogoTransparent, fit: BoxFit.contain),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}