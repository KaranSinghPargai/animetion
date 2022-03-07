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
  bool isLoading = false;

  void initiateSearch(String search) async {
    isLoading = true;
    await networking.jikanApiCallSearchedAnime(search);
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 10.0,right: 10.0,bottom: 5.0),
          child: Column(
            children: [
              TextField(
                style: const TextStyle(
                  color: Color(0xffE9A6A6),
                  fontFamily: 'Asap',
                ),
                cursorColor: Color(0xffE9A6A6),
                onSubmitted: (newVal) {
                  initiateSearch(newVal);
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
                      TextStyle(color: Color(0xff0B354F), fontFamily: 'Asap'),
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
                child: isLoading
                    ? Center(child: Container(child: Icon(Icons.hourglass_bottom_outlined,size: 400,),))
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.75,
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount: networking.listResponseSearchAnime.isEmpty
                            ? 0
                            : networking.listResponseSearchAnime.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    networking.listResponseSearchAnime[index]
                                        ['images']['jpg']['image_url']),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return AnimeInfoPage(
                                        networking.listResponseSearchAnime,
                                        index);
                                  }));
                                });
                              },
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
