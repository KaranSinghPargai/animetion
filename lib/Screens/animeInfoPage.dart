import 'package:animetion/networking.dart';
import 'package:flutter/material.dart';

class AnimeInfoPage extends StatefulWidget {
  AnimeInfoPage({required this.animeID, required this.animeIDIndex});
  final animeID;
  int animeIDIndex;
  @override
  _AnimeInfoPageState createState() => _AnimeInfoPageState();
}

class _AnimeInfoPageState extends State<AnimeInfoPage> {
  Networking networking = Networking();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff3F3351).withOpacity(0.8),
        appBar: AppBar(
          backgroundColor: Color(0xff3F3351),
          title: Center(
            child: Text('Animetion'),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 400,
              width: 200,
              child: Text(networking.listResponse[widget.animeIDIndex]['mal_id'].toString())
            ),
          ],
        ),
      ),
    );
  }
}
// data[0].images.jpg.large_image_url
