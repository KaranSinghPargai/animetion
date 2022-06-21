import 'package:flutter/material.dart';
import 'package:animetion/utilities/constants.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(height * 0.09),
        decoration: BoxDecoration(
          color: darkModePrimaryColor,
        ),
        child: Column(
          children: [
            Image.asset(
              'images/crying.png',
              height: height * 0.5,
              width: width * 0.5,
            ),
            const Center(
              child: Text(
                'Please check your internet Connection and try again',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
