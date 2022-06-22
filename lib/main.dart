import 'package:animetion/utilities/themeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:animetion/Screens/loading_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Animetion());
}

class Animetion extends StatefulWidget {
  @override
  State<Animetion> createState() => _AnimetionState();
}

class _AnimetionState extends State<Animetion>
    with SingleTickerProviderStateMixin {
  bool _isConnected = true;

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
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      builder: (context, widget) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(textTheme: GoogleFonts.firaSansTextTheme().apply()),
          home: LoadingScreen(isConnected: _isConnected),
        );
      },
    );
  }
}
