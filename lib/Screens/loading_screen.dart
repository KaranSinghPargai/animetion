import 'package:animetion/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:animetion/Screens/animeHomeScreen.dart';
import 'package:animetion/Screens/no_Internet.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
    required bool isConnected,
  })  : _isConnected = isConnected,
        super(key: key);

  final bool _isConnected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: const DecorationImage(
                fit: BoxFit.fill,
                opacity: 0.1,
                image: AssetImage('images/loading_Wallpaper.jpg')),
            color: darkModePrimaryColor),
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
                    Text(
                      'ANIME',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedTextKit(
                      onFinished: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return _isConnected
                              ? const AnimeHomeScreen()
                              : const NoInternet();
                        }));
                      },
                      animatedTexts: [
                        TyperAnimatedText(
                          'tion',
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 300),
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
