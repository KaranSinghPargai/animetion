import 'package:flutter/material.dart';
import 'package:animetion/Screens/animeHomeScreen.dart';
import 'package:animetion/Screens/no_Internet.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
    required bool isConnected,
  }) : _isConnected = isConnected, super(key: key);

  final bool _isConnected;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text('ANIME',style: TextStyle(color: Color(0xff0B354F),
                      fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedTextKit(
                        onFinished: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                            return _isConnected? AnimeHomeScreen():NoInternet();
                          }));
                        },
                        animatedTexts: [
                          TyperAnimatedText('tion',textStyle: TextStyle(color: Color(0xff0B354F),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: Duration(milliseconds: 500),
                          ),
                        ],
                        totalRepeatCount: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}