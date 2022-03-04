import 'package:animetion/Screens/video_player_screen.dart';
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
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xff3F3351).withOpacity(0.8),
        appBar: AppBar(
          backgroundColor: Color(0xff3F3351,),
          title: Center(
            child: Text('ANIMETION',style: TextStyle(fontFamily: 'Asap'),),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
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
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.listResponse[widget.animeIDIndex]['title']
                                  .toString(),
                              style: TextStyle(
                                  color: Color(0xffE9A6A6),
                                  fontFamily: 'Asap',
                                  fontSize: 25.0),
                            ),
                            Chip(
                              label: Text(
                                widget.listResponse[widget.animeIDIndex]
                                    ['type'],
                                style: TextStyle(
                                    color: Color(0xff3F3351),
                                    fontFamily: 'Asap',
                                    fontSize: 15.0),
                              ),
                              elevation: 5,
                              shadowColor: Color(0xffE9A6A6),
                            ),
                            Text(
                              'Released : ' +
                                  widget.listResponse[widget.animeIDIndex]
                                      ['status'],
                              style: TextStyle(
                                  color: Color(0xffE9A6A6),
                                  fontFamily: 'Asap',
                                  fontSize: 16.0),
                            ),
                            Chip(
                              label: Text(
                                widget.listResponse[widget.animeIDIndex]
                                    ['rating'],
                                style: TextStyle(
                                    color: Color(0xff3F3351),
                                    fontFamily: 'Asap',
                                    fontSize: 12.0),
                              ),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.star,
                                size: 70,
                                color: Color(0xffe9a6a6),
                              ),
                              trailing: Text(
                                widget.listResponse[widget.animeIDIndex]
                                        ['score']
                                    .toString(),
                                style: TextStyle(
                                    color: Color(0xffe9a6a6),
                                    fontFamily: 'Asap',
                                    fontSize: 35.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  ExpansionTile(
                    collapsedIconColor: Color(0xffE9A6A6),
                    title: Text(
                      'Synopsis',
                      style: TextStyle(
                          color: Color(0xffE9A6A6),
                          fontFamily: 'Asap',
                          fontSize: 16.0),
                    ),
                    children: [
                      ListTile(
                        title: Text(
                          widget.listResponse[widget.animeIDIndex]['synopsis']
                              .toString(),
                          style: TextStyle(
                              color: Color(0xffE9A6A6),
                              fontFamily: 'Asap',
                              fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  FutureBuilder(
                      future: networking.jikanApiCallGetAnimeVideos(
                          widget.listResponse[widget.animeIDIndex]['mal_id']),
                      builder: (context, snapshots) {
                        if (snapshots.data == null) {
                          return Text('loading');
                        }
                        print(snapshots.data);
                        return SizedBox(
                          height: 400,
                          child: ListView.builder(
                              itemCount: networking.listResponse.length,
                              itemBuilder: (context, index) {
                                print(networking.listResponse.length);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: Text(
                                      'Episode' +
                                          networking.listResponse[index]
                                                  ['mal_id']
                                              .toString(),
                                      style: TextStyle(
                                        color: Color(0xffE9A6A6),
                                        fontSize: 16,
                                        fontFamily: 'Asap',
                                      ),
                                    ),
                                    trailing: GestureDetector(
                                      onTap: (){
                                        String vidURL= networking.listResponse[index]['url'];
                                        Navigator.push(context, MaterialPageRoute(builder:(context){
                                          return VideoPlayerScreen(vidURL);
                                        }));
                                        print(vidURL);
                                      },
                                      child: Icon(
                                        Icons.play_arrow_rounded,
                                        size: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
