import 'package:flutter/material.dart';
class CustomText extends StatelessWidget {
  CustomText({required this.text,required this.color, required this.size});
  String text;
  Color color;
  double size;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: color,
          fontFamily: 'Asap',
          fontSize: size,
        ));
  }
}
