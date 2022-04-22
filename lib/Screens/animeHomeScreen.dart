import 'package:animetion/Screens/animeInfoPage.dart';
import 'package:animetion/Screens/search_Screen.dart';
import 'package:animetion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:animetion/services/networking.dart';
import 'dart:math';
import 'package:animetion/utilities/constants.dart';

class AnimeHomeScreen extends StatefulWidget {
  const AnimeHomeScreen({Key? key}) : super(key: key);

  @override
  _AnimeHomeScreenState createState() => _AnimeHomeScreenState();
}

class _AnimeHomeScreenState extends State<AnimeHomeScreen> {
  Networking netWorking = Networking();
  late Future topAnimeReference;
  late Future topCharacterReference;
  int randomImageGenerator = 0;
  @override
  void initState() {
    randomImageGenerator = Random().nextInt(13);
    topAnimeReference = netWorking.jikanApiCallTopAnime();
    topCharacterReference = netWorking.jikanApiCallTopCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accent_Color,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              accent_Color,
              primary_color,
            ],
            stops: const [0.3, 0.5],
          ),
        ),
        child: ListView(physics: const ClampingScrollPhysics(), children: [
          Container(
            height: height(context) * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
                color: accent_Color,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50.0),
                    bottomLeft: Radius.circular(50.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width(context) * 0.05),
                      child: CustomText(
                          text: 'Animetion',
                          color: secondary_color,
                          size: 30.0),
                    ),
                    TextButton(
                      child: Icon(
                        Icons.search,
                        color: secondary_color.withOpacity(0.8),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SearchScreen();
                        }));
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: width(context) * 0.05),
                  child: CustomText(
                      text: 'Top Characters',
                      color: secondary_color.withOpacity(0.7),
                      size: 20.0),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: height(context) * 0.03,
                        right: height(context) * 0.03,
                        bottom: height(context) * 0.05),
                    child: Stack(
                      children: [
                        FutureBuilder(
                            future: topCharacterReference,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: secondary_color,
                                  ),
                                );
                              }
                              return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1.45,
                                    crossAxisCount: 1,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: netWorking
                                      .listResponseTopCharacters.length,
                                  itemBuilder: (context, index) {
                                    return Stack(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(netWorking
                                                        .listResponseTopCharacters[
                                                    index]['images']['jpg']
                                                ['image_url']),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color:
                                                primary_color.withOpacity(0.5),
                                            borderRadius:
                                                const BorderRadius.only(
                                                  bottomLeft: Radius.circular(5.0),
                                              topRight: Radius.circular(5.0),
                                              bottomRight: Radius.circular(
                                                5.0,
                                              ),
                                            ),
                                          ),
                                          child: CustomText(
                                            text: netWorking
                                                    .listResponseTopCharacters[
                                                index]['name'],
                                            size: 18.0,
                                            color: secondary_color,
                                          ),
                                        ),
                                      ),
                                    ]);
                                  });
                            }),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Material(
                            color: secondary_color.withOpacity(0.8),
                            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                            elevation: 5.0,
                            child: Icon(
                              Icons.arrow_forward,
                              color: accent_Color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: width(context) * 0.05, top: width(context) * 0.05),
            child: CustomText(
                text: 'Top Anime',
                color: Colors.white.withOpacity(0.7),
                size: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder(
                future: topAnimeReference,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: Image.asset(
                      'images/image$randomImageGenerator.gif',
                      height: 200,
                      width: 200,
                    ));
                  }
                  return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.75,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: netWorking.listResponseTopAnime.isEmpty
                          ? 0
                          : netWorking.listResponseTopAnime.length,
                      itemBuilder: (context, index) {
                        return Hero(
                          tag: 'poster$index',
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    netWorking.listResponseTopAnime[index]
                                        ['images']['jpg']['image_url'],
                                  ),
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              // child: GestureDetector(
                              //   onTap: () {
                              //     setState(() {
                              //       Navigator.push(context,
                              //           MaterialPageRoute(builder: (context) {
                              //         return AnimeInfoPage(
                              //             netWorking.listResponseTopAnime,
                              //             index);
                              //       }));
                              //     });
                              //   },
                              // ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: primary_color.withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(5.0),
                                      bottomRight: Radius.circular(
                                        5.0,
                                      ),
                                    ),
                                  ),
                                  child: CustomText(
                                    text: netWorking.listResponseTopAnime[index]
                                            ['title']
                                        .toString(),
                                    size: 18.0,
                                    color: secondary_color,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return AnimeInfoPage(
                                            netWorking.listResponseTopAnime,
                                            index);
                                      }));
                                });
                              },
                            ),
                          ]),
                        );
                      });
                }),
          ),
        ]),
      ),
    );
  }
}
