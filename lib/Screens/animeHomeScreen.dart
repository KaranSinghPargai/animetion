import 'package:animetion/Screens/animeInfoPage.dart';
import 'package:animetion/Screens/search_Screen.dart';
import 'package:animetion/Screens/topAnime.dart';
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
  late Future recentEpisodes;
  int randomImageGenerator = 0;

  @override
  void initState() {
    randomImageGenerator = Random().nextInt(13);
    topAnimeReference = netWorking.jikanApiCallTopAnime();
    topCharacterReference = netWorking.jikanApiCallTopCharacters();
    recentEpisodes = netWorking.jikanApiCallRecentEpisodes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool darkmode = Provider.of<ThemeNotifier>(context).darkMode;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
            stops: const [0.2, 0.4],
          ),
        ),
        child: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: height * 0.25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: darkmode
                            ? darkModeAccentColor
                            : lightModeAccentColor,
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
                                  padding: EdgeInsets.only(left: width * 0.03),
                                  child: CustomText(
                                    text: 'Animetion',
                                    color:
                                        darkmode ? Colors.white : Colors.black,
                                    size: width / 12,
                                    customFontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color:
                                        darkmode ? Colors.white : Colors.black,
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
                                builder: (context, ThemeNotifier themeNotifier,
                                        child) =>
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
                                    });
                                  },
                                  iconBuilder: (value) => themeNotifier.darkMode
                                      ? const Icon(Icons.dark_mode)
                                      : const Icon(Icons.brightness_5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.03),
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
                              left: width * 0.08,
                              right: width * 0.08,
                            ),
                            child: TopCharactersSwiper(
                                topCharacterReference: topCharacterReference,
                                netWorking: netWorking),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.03,
                    right: width * 0.03,
                    top: width * 0.01,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Top Anime',
                        color: darkmode
                            ? Colors.white.withOpacity(0.7)
                            : Colors.black,
                        size: width / 23,
                        customFontWeight: FontWeight.bold,
                      ),
                      InkWell(
                          child: CustomText(
                            text: 'See more',
                            size: width / 30,
                            color: darkmode ? darkModeAccentColor : Colors.blue,
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return TopAnimePage(
                                netWorking.topAnimeResponse,
                              );
                            }));
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.03,
                      right: width * 0.03,
                      top: width * 0.01,
                    ),
                    child: FutureBuilder(
                        future: topAnimeReference,
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
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1.6,
                                crossAxisCount: 1,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: 10,
                              // netWorking.hasNextPage
                              //     ? netWorking.topAnimeResponse.length + 1
                              //     : netWorking.topAnimeResponse.length,
                              itemBuilder: (context, index) {
                                if (index <
                                    netWorking.topAnimeResponse.length) {
                                  return Hero(
                                    tag: 'poster$index',
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return AnimeInfoPage(
                                                netWorking.topAnimeResponse,
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
                                                    netWorking.topAnimeResponse[
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
                                            width: 5,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Material(
                                              color: Colors.transparent,
                                              child: CustomText(
                                                maxLines: 2,
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
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.03, top: width * 0.01),
                  child: CustomText(
                    text: 'Recent Episodes',
                    color:
                        darkmode ? Colors.white.withOpacity(0.7) : Colors.black,
                    size: width / 23,
                    customFontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.03,
                        right: width * 0.03,
                        top: width * 0.01),
                    child: FutureBuilder(
                        future: recentEpisodes,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'images/image${randomImageGenerator + 1}.gif',
                                ));
                          }
                          return GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1.6,
                                crossAxisCount: 1,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: netWorking
                                      .recentEpisodesResponse.isEmpty
                                  ? 1
                                  : netWorking.recentEpisodesResponse.length,
                              itemBuilder: (context, index) {
                                if (netWorking.recentEpisodesResponse.isEmpty) {
                                  return const CircularProgressIndicator();
                                } else {
                                  return Hero(
                                    tag: 'recent$index',
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
                                                  netWorking.recentEpisodesResponse[
                                                              index]['entry']
                                                          ['images']['jpg']
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
                                          width: 5,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: Column(
                                              children: [
                                                CustomText(
                                                  maxLines: 1,
                                                  text: netWorking
                                                      .recentEpisodesResponse[
                                                          index]['entry']
                                                          ['title']
                                                      .toString(),
                                                  size: width / 25,
                                                  color: darkmode
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                                CustomText(
                                                  text: netWorking
                                                      .recentEpisodesResponse[
                                                          index]['episodes'][0]
                                                          ['title']
                                                      .toString(),
                                                  size: width / 25,
                                                  color: darkmode
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              });
                        }),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
