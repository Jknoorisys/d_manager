import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double? size;
  FontWeight? weight;
  TextOverflow? overflow;

  BigText({super.key, this.color = const Color(0xFF5c524f), required this.text, this.size = 0, this.weight = FontWeight.w500, this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? 24 : size,
        fontWeight: weight,
        fontFamily: 'Oswald',
      ),
    );
  }
}

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double? size;
  double? height;
  TextOverflow? overflow;

  SmallText({super.key, this.color = const Color(0xEF8f837f), required this.text, this.size = 0, this.height = 1.2, this.overflow = TextOverflow.visible});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? 12 : size,
        height: height,
        overflow: overflow,
      ),
    );
  }
}
