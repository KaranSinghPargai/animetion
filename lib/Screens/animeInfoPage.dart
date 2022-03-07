import 'package:animetion/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimeInfoPage extends StatefulWidget {
  AnimeInfoPage(this.listResponse, this.animeIDIndex);
  List listResponse;
  int animeIDIndex;
  @override
  _AnimeInfoPageState createState() => _AnimeInfoPageState();
}

class _AnimeInfoPageState extends State<AnimeInfoPage> {
  Networking networking = Networking();
  @override
  Widget build(BuildContext context) {
    var data = widget.listResponse[widget.animeIDIndex];
    List genreBuild = widget.listResponse[widget.animeIDIndex]['genres'];
    List studiosBuilder=[];
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.1,
            fit: BoxFit.fill,
            image: NetworkImage(data['images']['jpg']['image_url']),
          ),
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 285,
                        width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              widget.listResponse[widget.animeIDIndex]
                                  ['images']['jpg']['image_url'],
                            ),
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ), //Poster
                  SizedBox(height: 20.0),
                  Text(
                    widget.listResponse[widget.animeIDIndex]['title']
                        .toString(),
                    style: TextStyle(
                        color: Color(0xff0B354F),
                        fontFamily: 'Asap',
                        fontSize: 25.0),
                  ), //Title
                  SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 30.0,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: genreBuild.length,
                              itemBuilder: (context, index) {
                                if (genreBuild.isEmpty) {
                                  return SizedBox(
                                    height: 1,
                                    width: 0,
                                  );
                                }
                                return Chip(
                                    label: Text(genreBuild[index]['name']));
                              }),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        size: 30,
                        color: Colors.orangeAccent,
                      ),
                      SizedBox(width: 15.0,),
                      widget.listResponse[widget.animeIDIndex]
                                  ['score'] ==
                              null
                          ? Text(
                              'N/A',
                              style: TextStyle(
                                  color: Color(0xff0B354F),
                                  fontFamily: 'Asap',
                                  fontSize: 18.0),
                            )
                          : Text(
                              widget.listResponse[widget.animeIDIndex]['score']
                                  .toString(),
                              style: TextStyle(
                                  color: Color(0xff0B354F).withOpacity(0.7),
                                  fontFamily: 'Asap',
                                  fontSize: 35.0),
                            ),
                    ],
                  ), //Rating
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: widget.listResponse[widget.animeIDIndex]
                                    ['episodes'] ==
                                null
                            ? Text(
                                'Not Aired',
                                style: TextStyle(
                                  color: Color(0xff0B354F).withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ),
                              )
                            : Text(
                                widget.listResponse[widget.animeIDIndex]
                                            ['episodes']
                                        .toString() +
                                    ' Episodes',
                                style: TextStyle(
                                  color: Color(0xff0B354F).withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Type',
                                  style: TextStyle(
                                    color: Color(0xff0B354F).withOpacity(0.7),
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: 7.0),
                                Text(
                                  widget.listResponse[widget.animeIDIndex]
                                      ['type'],
                                  style: TextStyle(
                                      color: Color(0xff0B354F),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Status',
                                  style: TextStyle(
                                      color:
                                          Color(0xff0B354F).withOpacity(0.7),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12.0),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  widget.listResponse[widget.animeIDIndex]
                                      ['status'],
                                  style: TextStyle(
                                      color: Color(0xff0B354F),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rating',
                                  style: TextStyle(
                                      color:
                                          Color(0xff0B354F).withOpacity(0.7),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12.0),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  widget.listResponse[widget.animeIDIndex]
                                      ['rating'],
                                  style: TextStyle(
                                      color: Color(0xff0B354F),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Duration',
                                  style: TextStyle(
                                      color:
                                          Color(0xff0B354F).withOpacity(0.7),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12.0),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                widget.listResponse[widget.animeIDIndex]
                                ['duration']==null?
                                    Text('Unknown',style: TextStyle(
                                        color: Color(0xff0B354F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),):
                                Text(
                                  widget.listResponse[widget.animeIDIndex]
                                      ['duration'].toString(),
                                  style: TextStyle(
                                      color: Color(0xff0B354F),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ExpansionTile(
                    iconColor: Color(0xff0B354F),
                    collapsedIconColor: Color(0xff0B354F),
                    title: Text(
                      'Synopsis',
                      style: TextStyle(
                          color: Color(0xff0B354F),
                          fontFamily: 'Asap',
                          fontSize: 16.0),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          widget.listResponse[widget.animeIDIndex]['synopsis']
                              .toString(),
                          style: TextStyle(
                              color: Color(0xff0B354F).withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'English Name',
                              style: TextStyle(
                                  color: Color(0xff0B354F).withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                            ),
                            SizedBox(height: 5.0),
                            widget.listResponse[widget.animeIDIndex]
                                        ['title_english'] ==
                                    null
                                ? Text(
                                    'N/A',
                                    style: TextStyle(
                                        color: Color(0xff0B354F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  )
                                : Text(
                                    widget.listResponse[widget.animeIDIndex]
                                        ['title_english'].toString(),
                                    style: TextStyle(
                                        color: Color(0xff0B354F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Rank',
                              style: TextStyle(
                                  color: Color(0xff0B354F).withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                            ),
                            SizedBox(height: 10.0),
                            widget.listResponse[widget.animeIDIndex]
                                        ['rank']==
                                    null
                                ? Text(
                                    'No Data',
                                    style: TextStyle(
                                        color: Color(0xff0B354F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  )
                                : Text(
                                    widget.listResponse[widget.animeIDIndex]
                                            ['rank']
                                        .toString(),
                                    style: TextStyle(
                                        color: Color(0xff0B354F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Season',
                              style: TextStyle(
                                  color: Color(0xff0B354F).withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            widget.listResponse[widget.animeIDIndex]
                                        ['season'] ==
                                    null
                                ? Text(
                                    'No Data',
                                    style: TextStyle(
                                        color: Color(0xff0B354F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  )
                                : Text(
                                    widget.listResponse[widget.animeIDIndex]
                                                    ['season'],
                                    style: TextStyle(
                                        color: Color(0xff0B354F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Studio',
                              style: TextStyle(
                                  color: Color(0xff0B354F).withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            data['studios'].isEmpty
                                ? Text(
                                    'Unknown',
                                    style: TextStyle(
                                        color: Color(0xff0B354F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  )
                                : Text(
                                    data['studios'][0]['name'].toString(),
                                    style: TextStyle(
                                        color: Color(0xff0B354F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Aired',
                              style: TextStyle(
                                  color: Color(0xff0B354F).withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            data['aired']['string'] == null
                                ? Text(
                                    'No Data',
                                    style: TextStyle(
                                        color: Color(0xff0B354F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  )
                                : Text(
                                    data['aired']['string'].toString(),
                                    style: TextStyle(
                                        color: Color(0xff0B354F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
