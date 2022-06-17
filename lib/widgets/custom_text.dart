import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  CustomText({
    required this.text,
    required this.color,
    required this.size,
    this.customFontWeight,
    this.maxLines,
  });
  String text;
  Color color;
  double size;
  FontWeight? customFontWeight;
  int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines ?? 2,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: color,
          fontWeight: customFontWeight ?? FontWeight.normal,
          fontSize: size,
        ));
  }
}
