import 'package:flutter/material.dart';

class AddHorizontalSpace extends StatelessWidget {
  final double width;
  AddHorizontalSpace(this.width);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

class AddVerticalSpace extends StatelessWidget {
  double height;
  AddVerticalSpace(this.height);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
