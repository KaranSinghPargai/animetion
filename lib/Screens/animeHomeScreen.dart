import 'package:animetion/Screens/animeInfoPage.dart';
import 'package:animetion/Screens/search_Screen.dart';
import 'package:animetion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:animetion/services/networking.dart';
import 'dart:math';
import 'package:animetion/utilities/constants.dart';
import 'package:animetion/widgets/topCharacterSwiper.dart';
import 'package:shimmer/shimmer.dart';

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
  int page = 2;
  final ScrollController _scrollController = ScrollController();
  bool showFAB = false;
  @override
  void initState() {
    randomImageGenerator = Random().nextInt(13);
    topAnimeReference = netWorking.jikanApiCallTopAnime();
    topCharacterReference = netWorking.jikanApiCallTopCharacters();
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          topAnimeReference = netWorking.jikanApiCallTopAnimeByPage(page);
          showFAB = true;
          page++;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollUp() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: showFAB
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.fromRadius(width / 15),
                shape: const CircleBorder(),
                elevation: 10,
              ),
              onPressed: _scrollUp,
              child: Icon(
                Icons.arrow_upward,
                size: width / 15,
              ),
            )
          : Container(),
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
                            left: width * 0.03,
                            right: width * 0.03,
                            bottom: height * 0.05),
                        child: Stack(
                          children: [
                            TopCharactersSwiper(
                                topCharacterReference: topCharacterReference,
                                netWorking: netWorking),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.03, top: width * 0.05),
                child: CustomText(
                    text: 'Top Anime',
                    color: Colors.white.withOpacity(0.7),
                    size: 20),
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.03),
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
                      return TopAnimeGridView(width);
                    }),
              ),
            ]),
      ),
    );
  }

  GridView TopAnimeGridView(double width) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.6,
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
        ),
        itemCount: netWorking.topAnimeResponse.length + 1,
        itemBuilder: (context, index) {
          if (index < netWorking.topAnimeResponse.length) {
            return Hero(
              tag: 'poster$index',
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AnimeInfoPage(netWorking.topAnimeResponse, index);
                    }),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 9,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              netWorking.topAnimeResponse[index]['images']
                                  ['jpg']['image_url'],
                            ),
                          ),
                          borderRadius: const BorderRadius.all(
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
                          text: netWorking.topAnimeResponse[index]['title']
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
          } else {
            return Column(
              children: [
                Expanded(
                  flex: 9,
                  child: Shimmer.fromColors(
                    child: Container(
                      color: Colors.grey,
                    ),
                    baseColor: Colors.transparent,
                    highlightColor: Colors.grey[300]!,
                    enabled: true,
                    direction: ShimmerDirection.ttb,
                  ),
                ),
                Expanded(flex: 2, child: Container()),
              ],
            );
          }
        });
  }
}
