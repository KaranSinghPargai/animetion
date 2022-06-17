import 'package:animetion/Screens/animeInfoPage.dart';
import 'package:animetion/Screens/search_Screen.dart';
import 'package:animetion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:animetion/services/networking.dart';
import 'dart:math';
import 'package:animetion/utilities/constants.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class AnimeHomeScreen extends StatefulWidget {
  const AnimeHomeScreen({Key? key}) : super(key: key);

  @override
  _AnimeHomeScreenState createState() => _AnimeHomeScreenState();
}

class _AnimeHomeScreenState extends State<AnimeHomeScreen> {
  Networking netWorking = Networking();
  late Future topAnimeReference;
  late Future topCharacterReference;
  late Future topAnimeReferencePage;
  int randomImageGenerator = 0;
  int pageNumber = 1;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    randomImageGenerator = Random().nextInt(13);
    topAnimeReference = netWorking.jikanApiCallTopAnime();
    topCharacterReference = netWorking.jikanApiCallTopCharacters();
    super.initState();
  }

  void _scrollUp() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    topAnimeReferencePage = netWorking.jikanApiCallTopAnimeByPage(pageNumber);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
        child: ListView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            children: [
              Container(
                height: height * 0.4,
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
                          padding: EdgeInsets.only(left: width * 0.05),
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
                              return const SearchScreen();
                            }));
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
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
                            left: height * 0.03,
                            right: height * 0.03,
                            bottom: height * 0.05),
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
                                  return Swiper(
                                    autoplay: true,
                                    duration: 200,
                                    viewportFraction: 0.5,
                                    scale: 0.3,
                                    itemCount: netWorking
                                        .listResponseTopCharacters.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          border: Border.all(
                                              color: Colors.white, width: 3),
                                        ),
                                        child: GridTile(
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            child: Image.network(
                                              netWorking.listResponseTopCharacters[
                                                      index]['images']['jpg']
                                                  ['image_url'],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          footer: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: primary_color
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(20.0),
                                                bottomRight: Radius.circular(
                                                  20.0,
                                                ),
                                              ),
                                            ),
                                            child: CustomText(
                                              text: netWorking
                                                      .listResponseTopCharacters[
                                                  index]['name'],
                                              size: 15.0,
                                              color: secondary_color,
                                              customFontWeight: FontWeight.bold,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.05, top: width * 0.05),
                child: CustomText(
                    text: 'Top Anime',
                    color: Colors.white.withOpacity(0.7),
                    size: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FutureBuilder(
                    future: pageNumber == 1
                        ? topAnimeReference
                        : topAnimeReferencePage,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: Image.asset(
                          'images/image$randomImageGenerator.gif',
                          height: 200,
                          width: 200,
                        ));
                      }
                      return Column(
                        children: [
                          GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.6,
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                              ),
                              itemCount: netWorking.listResponseTopAnime.length,
                              itemBuilder: (context, index) {
                                return Hero(
                                  tag: 'poster$index',
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return AnimeInfoPage(
                                              netWorking.listResponseTopAnime,
                                              index);
                                        }),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 9,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  netWorking.listResponseTopAnime[
                                                          index]['images']
                                                      ['jpg']['image_url'],
                                                ),
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(5.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: CustomText(
                                              text: netWorking
                                                  .listResponseTopAnime[index]
                                                      ['title']
                                                  .toString(),
                                              size: width / 25,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                pageNumber = 2;

                                networking.jikanApiCallTopAnimeByPage(2);
                                // networking.listResponseTopAnime;
                              });
                              _scrollUp();
                            },
                            child: Text('Page No. 2'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                pageNumber = 3;
                                networking.jikanApiCallTopAnimeByPage(3);
                                // networking.listResponseTopAnime;
                              });
                            },
                            child: Text('Page No. 3'),
                          ),
                        ],
                      );
                    }),
              ),
            ]),
      ),
    );
  }
}
