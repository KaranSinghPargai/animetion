import 'package:animetion/Screens/animeHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
void main() {
  runApp(Animetion());
}
class Animetion extends StatefulWidget {
  @override
  State<Animetion> createState() => _AnimetionState();
}

class _AnimetionState extends State<Animetion> {

  bool _isConnected= true;

  Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        setState(() {
          _isConnected = true;
        });
      }
    } on SocketException catch (err) {
      setState(() {
        _isConnected = false;
      });
      if (kDebugMode) {
        print(err);
      }
    }
  }
  @override
  void initState() {
    _checkInternetConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _isConnected? AnimeHomeScreen(): Scaffold(
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
      ),
    );
  }
}