import 'package:animetion/Screens/animeHomeScreen.dart';
import 'package:animetion/Screens/search_Screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tabs=[
    AnimeHomeScreen(),
    SearchScreen(),
  ];
  int _currentIndex=0; //For bottom navigationBar
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor:  Color(0xff3F3351),
          unselectedItemColor: Color(0xffE9A6A6).withOpacity(0.5),
          selectedItemColor: Color(0xffE9A6A6),
          onTap: (index){
            setState(() {
              _currentIndex= index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.info_outline), label: 'Info'),
          ],
        ),
        body: tabs[_currentIndex],
      ),
    );
  }
}
