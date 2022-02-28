import 'package:animetion/Screens/animeHomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Animetion());
}
class Animetion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:AnimeHomeScreen(),
    );
  }
}