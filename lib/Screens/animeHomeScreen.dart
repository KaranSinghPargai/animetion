import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const String jikanApiURL = 'https://api.jikan.moe/v4';
class AnimeHomeScreen extends StatefulWidget {
  const AnimeHomeScreen({Key? key}) : super(key: key);

  @override
  _AnimeHomeScreenState createState() => _AnimeHomeScreenState();
}

class _AnimeHomeScreenState extends State<AnimeHomeScreen> {
  String searchAnimeID='';
  List listResponse = [];
  Map mapResponse={};

  Future jikanApiCall() async {
    http.Response apiResponse;
    apiResponse = await http.get(Uri.parse('$jikanApiURL/anime?q=$searchAnimeID'));
    print(apiResponse.statusCode);
    if (apiResponse.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(apiResponse.body);
        listResponse = mapResponse['data'];
      });
    }
  }

  // @override
  // void initState() {
  //   jikanApiCall();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Animetion')),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
               onSubmitted:(newVal){
                 setState(() {
                   searchAnimeID= newVal;
                   jikanApiCall();
                 });
               },
              decoration: const InputDecoration(
                hintText: 'Search Anime Here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.lightBlueAccent,
          onTap:null,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.info_outline), label: 'Info'),
          ],
        ),
      ),
    );
  }
}
