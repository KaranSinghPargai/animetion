import 'package:animetion/Screens/animeInfoPage.dart';
import 'package:animetion/networking.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

Networking networking = Networking();
int animeID = 0;

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff3F3351),
        body: Padding(
          padding: const EdgeInsets.only(
              top: 30.0, left: 10.0, bottom: 10.0, right: 10.0),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                style: const TextStyle(
                  color: Color(0xffE9A6A6),
                  fontFamily: 'Asap',
                ),
                cursorColor: Color(0xffE9A6A6),
                onSubmitted: (newVal) {
                  setState(() {
                    networking.jikanApiCallSearchedAnime(newVal);
                    print(networking.listResponse);
                  });
                },
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                      color: Color(0xffE9A6A6),
                    ),
                  ),
                  hintStyle:
                      TextStyle(color: Color(0xffE9A6A6), fontFamily: 'Asap'),
                  hintText: 'Search Anime Here',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffE9A6A6),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
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
                        child: GestureDetector(
                          onTap: () {
                            setState((){
                              animeID =
                              networking.listResponse[index]['mal_id'];
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return AnimeInfoPage(networking.listResponse,index);
                                  }));
                            });
                          },
                          child: Container(
                            height: 400,
                            width: 200,
                            child: Image.network(
                              networking.listResponse[index]['images']['jpg']
                              ['image_url'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
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
