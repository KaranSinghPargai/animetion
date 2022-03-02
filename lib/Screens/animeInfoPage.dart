import 'package:animetion/networking.dart';
import 'package:flutter/material.dart';

class AnimeInfoPage extends StatefulWidget {
  AnimeInfoPage(this.listResponse, this.animeIDIndex);
  List listResponse;
  // final animeID;
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 285,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          widget.listResponse[widget.animeIDIndex]['images']
                              ['jpg']['image_url'],
                        ),
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.listResponse[widget.animeIDIndex]['title']
                          .toString(),
                      style: TextStyle(
                          color: Color(0xffE9A6A6),
                          fontFamily: 'Asap',
                          fontSize: 25.0),
                    ),
                  ),
                  Text(widget.listResponse[widget.animeIDIndex]['type'],style:TextStyle(
                      color: Color(0xffE9A6A6),
                      fontFamily: 'Asap',
                      fontSize: 10.0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//data[0].title
