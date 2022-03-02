import 'package:animetion/Screens/search_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:animetion/networking.dart';

class AnimeHomeScreen extends StatefulWidget {
  @override
  _AnimeHomeScreenState createState() => _AnimeHomeScreenState();
}

class _AnimeHomeScreenState extends State<AnimeHomeScreen> {
  Networking netWorking = Networking();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff3F3351),
        appBar: AppBar(
          backgroundColor: Color(0xff3F3351),
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder(
                  future: netWorking.jikanApiCallTopAnime(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      // Future hasn't finished yet, return a placeholder
                      return Text('Loading');
                    }
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.7,
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount: networking.listResponse.isEmpty
                            ? 0
                            : networking.listResponse.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight,
                                  colors: [
                                    Color(0xff3F3351).withOpacity(1),
                                    Color(0xff864879).withOpacity(0.7),
                                    Color(0xff864879).withOpacity(0.5),
                                    Color(0xff864879).withOpacity(0.3),
                                    Color(0xff864879).withOpacity(0.0),
                                  ],
                                  stops: const [
                                    0.0,
                                    0.25,
                                    0.5,
                                    0.75,
                                    1.0
                                  ]),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            child: Image.network(
                              networking.listResponse[index]['images']['jpg']
                                  ['image_url'],
                              fit: BoxFit.cover,
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

//netWorking.listResponse[index]['images']['jpg']
//                               ['image_url'],
