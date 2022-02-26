import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:animetion/networking.dart';

const String jikanApiURL = 'https://api.jikan.moe/v4';

class AnimeHomeScreen extends StatefulWidget {
  const AnimeHomeScreen({Key? key}) : super(key: key);

  @override
  _AnimeHomeScreenState createState() => _AnimeHomeScreenState();
}

class _AnimeHomeScreenState extends State<AnimeHomeScreen> {
  List listResponse = [];
  Map mapResponse = {};
  Networking netWorking = Networking();

  @override
  void initState() {
    netWorking.jikanApiCallTopAnime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Center(child: Text('Animetion')),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (newVal) {
                setState(() {
                  netWorking.jikanApiCall(newVal);
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
            Expanded(
              child: GridView.builder(

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.7,
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: netWorking.listResponse.isEmpty
                      ? 0
                      : netWorking.listResponse.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: FractionalOffset.topLeft,
                              end: FractionalOffset.bottomRight,
                              colors: [
                                Colors.white.withOpacity(1),
                                Colors.white.withOpacity(0.7),
                                Colors.white.withOpacity(0.5),
                                Colors.white.withOpacity(0.3),
                                Colors.white.withOpacity(0.0),
                              ],
                              stops: [0.0,0.25,0.5,0.75,1.0]
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      child: Image.network(
                        netWorking.listResponse[index]['images']['jpg']
                            ['image_url'],
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.softLight,
                      ),
                    );
                  }),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.lightBlueAccent,
          onTap: null,
          items: [
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
