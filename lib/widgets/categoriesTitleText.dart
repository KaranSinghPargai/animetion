import 'package:flutter/material.dart';
import 'package:animetion/utilities/constants.dart';

class CategoryTitleText extends StatelessWidget {
 CategoryTitleText(this.text);
 String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color:
          secondary_color.withOpacity(0.7),
          fontFamily: 'Asap',
          fontSize: 12.0),
    );
  }
}

class CategoryText extends StatelessWidget {
CategoryText(this.text);
String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: secondary_color,
          fontSize: 15.0,
          fontFamily: 'Asap',
          ),
    );
  }
}
