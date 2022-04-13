import 'package:flutter/material.dart';

double height(BuildContext context) {
  double Screenheight = MediaQuery.of(context).size.height;
  return Screenheight;
}

double width(BuildContext context) {
  double ScreenWidth = MediaQuery.of(context).size.width;
  return ScreenWidth;
}
Color primary_color = Color(0xff2C3333);
Color accent_Color = Colors.deepOrangeAccent;
Color secondary_color= Color(0xffF5F2E7);

