import 'package:animetion/Screens/animeInfoPage.dart';
import 'package:animetion/Screens/search_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:animetion/networking.dart';
import 'dart:math';

class AnimeHomeScreen extends StatefulWidget {
  @override
  _AnimeHomeScreenState createState() => _AnimeHomeScreenState();
}

class _AnimeHomeScreenState extends State<AnimeHomeScreen> {
  Networking netWorking = Networking();
  int randomImageGenerator=0;
@override
  void initState() {
    randomImageGenerator= Random().nextInt(13);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff3A1C71),
          title: Center(
            child: Text(
              'ANIMETION',
              style: TextStyle(fontFamily: 'Asap'),
            ),
          ),
          actions: [
            TextButton(
              child: Icon(
                Icons.search,
                color: Color(0xffE9A6A6),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchScreen();
                }));
              },
            ),
          ],
        ),
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
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                    future: netWorking.jikanApiCallTopAnime(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        // Future hasn't finished yet, return a placeholder
                        return Center(child: Image.asset('images/image$randomImageGenerator.gif',height: 500, width: 300,));
                      }
                      // netWorking.listResponse= snapshot;
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.7,
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount: netWorking.listResponseTopAnime.isEmpty
                                ? 0
                                : netWorking.listResponseTopAnime.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      netWorking.listResponseTopAnime[index]['images']
                                          ['jpg']['image_url'],
                                    ),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return AnimeInfoPage(
                                            netWorking.listResponseTopAnime, index);
                                      }));
                                    });
                                  },
                                ),
                              );
                            }),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}