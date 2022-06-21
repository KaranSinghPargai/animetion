import 'package:animetion/Screens/animeInfoPage.dart';
import 'package:animetion/Screens/search_Screen.dart';
import 'package:animetion/utilities/themeNotifier.dart';
import 'package:animetion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:animetion/services/networking.dart';
import 'dart:math';
import 'package:animetion/utilities/constants.dart';
import 'package:animetion/widgets/topCharacterSwiper.dart';
import 'package:animetion/widgets/loading_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

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
    setState(() {
      showFAB = false;
      topAnimeReference = netWorking.jikanApiCallTopAnime();
      page = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkmode = Provider.of<ThemeNotifier>(context).darkMode;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: AnimatedOpacity(
        opacity: showFAB ? 1 : 0.0,
        duration: const Duration(milliseconds: 1500),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: darkmode ? darkModeAccentColor : lightModeAccentColor,
            padding: const EdgeInsets.all(10),
            minimumSize: Size.fromRadius(width / 15),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            elevation: 20,
          ),
          onPressed: _scrollUp,
          child: CustomText(
              text: 'Scroll to top',
              color: darkmode ? Colors.white : Colors.black,
              size: 15),
        ),
      ),
      backgroundColor: darkmode ? darkModeAccentColor : lightModePrimaryColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              darkmode ? darkModeAccentColor : lightModeAccentColor,
              darkmode ? darkModePrimaryColor : lightModePrimaryColor,
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
                    color:
                        darkmode ? darkModeAccentColor : lightModeAccentColor,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(50.0),
                        bottomLeft: Radius.circular(50.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.05),
                              child: CustomText(
                                text: 'Animetion',
                                color: darkmode ? Colors.white : Colors.black,
                                size: width / 12,
                                customFontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.search,
                                color: darkmode ? Colors.white : Colors.black,
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
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Consumer(
                            builder:
                                (context, ThemeNotifier themeNotifier, child) =>
                                    AnimatedToggleSwitch.dual(
                              current: themeNotifier.darkMode,
                              first: false,
                              second: true,
                              dif: 0.0,
                              innerColor: darkmode
                                  ? darkModePrimaryColor
                                  : lightModePrimaryColor,
                              colorBuilder: (b) => darkmode
                                  ? darkModeAccentColor
                                  : lightModeAccentColor,
                              animationOffset: const Offset(10, 0),
                              borderColor: Colors.transparent,
                              borderWidth: 2.0,
                              height: width / 10,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 1.5),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  themeNotifier.darkMode = value as bool;
                                  print(themeNotifier.darkMode
                                      ? 'darkmode'
                                      : 'lightmode');
                                });
                              },
                              iconBuilder: (value) => themeNotifier.darkMode
                                  ? Icon(Icons.dark_mode)
                                  : Icon(Icons.brightness_5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: CustomText(
                          text: 'Top Characters',
                          color: darkmode ? Colors.white : Colors.black,
                          size: width / 20),
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
                  color:
                      darkmode ? Colors.white.withOpacity(0.7) : Colors.black,
                  size: width / 20,
                  customFontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.03),
                child: StreamBuilder(
                    stream: topAnimeReference.asStream(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'images/image$randomImageGenerator.gif',
                              height: 200,
                              width: 200,
                            ));
                      }
                      return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.6,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                          ),
                          itemCount: netWorking.hasNextPage
                              ? netWorking.topAnimeResponse.length + 1
                              : netWorking.topAnimeResponse.length,
                          itemBuilder: (context, index) {
                            if (index < netWorking.topAnimeResponse.length) {
                              return Hero(
                                tag: 'poster$index',
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return AnimeInfoPage(
                                            netWorking.topAnimeResponse, index);
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
                                                netWorking.topAnimeResponse[
                                                        index]['images']['jpg']
                                                    ['image_url'],
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
                                                .topAnimeResponse[index]
                                                    ['title']
                                                .toString(),
                                            size: width / 25,
                                            color: darkmode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return networking.hasNextPage
                                  ? const LoadingShimmer()
                                  : Container();
                            }
                          });
                    }),
              ),
            ]),
      ),
    );
  }
}
