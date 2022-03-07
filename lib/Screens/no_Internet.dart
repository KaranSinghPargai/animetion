import 'package:flutter/material.dart';
class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Color(0xff3A1C71).withOpacity(0.8),
              Color(0xff3A1C71).withOpacity(0.4),
              Color(0xffD76D77).withOpacity(0.4),
              Color(0xffD76D77).withOpacity(0.3),
              Color(0xffFFAF7B).withOpacity(0.3),
            ],
            stops: const [0.0,0.25,0.5,0.75,1.0],
          ),
        ),
        child: Center(
          child: Text('No Internet Access',style: TextStyle(
            color: Color(0xff0B354F),
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),),
        ),
      ),
    );
  }
}
