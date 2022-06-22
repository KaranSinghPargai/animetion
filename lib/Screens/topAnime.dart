import 'package:animetion/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:animetion/services/networking.dart';
import 'package:animetion/Screens/animeInfoPage.dart';
import 'package:animetion/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:animetion/widgets/loading_shimmer.dart';
import 'package:animetion/utilities/themeNotifier.dart';
import 'package:shimmer/shimmer.dart';

class TopAnimePage extends StatefulWidget {
  TopAnimePage(this.topAnimeData);
  List topAnimeData;
  @override
  State<TopAnimePage> createState() => _TopAnimePageState();
}

class _TopAnimePageState extends State<TopAnimePage> {
  Networking netWorking = Networking();
  final ScrollController _scrollController = ScrollController();
  late Future topAnimeReference;
  bool showFAB = false;
  int page = 2;
  @override
  void initState() {
    topAnimeReference = netWorking.jikanApiCallTopAnime();
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      backgroundColor: darkmode ? darkModePrimaryColor : lightModePrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: width / 50,
            right: width / 50,
          ),
          child: FutureBuilder(
              future: topAnimeReference,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Shimmer.fromColors(
                    child: Container(
                      height: height,
                      width: width,
                      color: Colors.grey,
                    ),
                    baseColor: Colors.transparent,
                    highlightColor: Colors.grey[300]!,
                    enabled: true,
                    direction: ShimmerDirection.ttb,
                  );
                }
                return GridView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.6,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          netWorking.topAnimeResponse[index]
                                              ['images']['jpg']['image_url'],
                                        ),
                                      ),
                                      borderRadius: const BorderRadius.all(
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
                                      text: netWorking.topAnimeResponse[index]
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
                        return netWorking.hasNextPage
                            ? const LoadingShimmer()
                            : Container();
                      }
                    });
              }),
        ),
      ),
    );
  }
}
