import 'package:flutter/material.dart';
import 'package:animetion/utilities/constants.dart';
class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(height(context)*0.09),
        decoration: BoxDecoration(
          color: primary_color,
        ),
        child: Column(
          children: [
            Image.asset('images/crying.png',height: height(context)*0.5,width: width(context)*0.5,),
            Center(
              child: Text('Please check your internet and try again',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: secondary_color,
                    fontFamily: 'Asap',
                    fontSize: 25.0,
                  ))
            ),
          ],
        ),
      ),
    );
  }
}
