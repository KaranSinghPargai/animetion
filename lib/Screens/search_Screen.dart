import 'package:animetion/Screens/animeInfoPage.dart';
import 'package:animetion/services/networking.dart';
import 'package:animetion/utilities/constants.dart';
import 'package:animetion/utilities/themeNotifier.dart';
import 'package:animetion/widgets/addSpace.dart';
import 'package:animetion/widgets/custom_text.dart';
import 'package:animetion/widgets/loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

Networking networking = Networking();

class _SearchScreenState extends State<SearchScreen> {
  // Local variables
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;
  int page = 2;
  final ScrollController _scrollController = ScrollController();
  bool showFAB = false;
  bool hasMore = true;
  String userSearch = '';

// Local functions
  void initiateSearch(String search) async {
    if (page >= 3) {
      page = 2;
    }
    isLoading = true;
    await networking.jikanApiCallSearchedAnime(search);
    setState(() {
      isLoading = false;
      networking.hasNextPage;
    });
  }

  void _scrollUp() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
    );
  }

  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }

  String searchText(String search) {
    setState(() {
      userSearch = search;
    });

    return userSearch;
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        scrollBypage();
      }
    });
    super.initState();
  }

  void scrollBypage() async {
    if (networking.hasNextPage) {
      await networking.jikanApiCallSearchedAnimeByPage(userSearch, page);
      setState(() {
        networking.searchAnimeResponse;
        showFAB = true;
        page++;
        networking.hasNextPage;
      });
    }
    if (!networking.hasNextPage) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("You've reached the end of the results")));
    }
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
      key: _scaffoldKey,
      backgroundColor: darkmode ? darkModePrimaryColor : lightModePrimaryColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              darkmode ? darkModeAccentColor : lightModeAccentColor,
              darkmode ? darkModePrimaryColor : lightModePrimaryColor
            ],
            stops: const [0.3, 0.5],
          ),
        ),
        child: ListView(
          controller: _scrollController,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: height * 0.02, left: width * 0.02, right: width * 0.02),
              height: height * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: darkmode ? darkModeAccentColor : lightModeAccentColor,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50.0),
                      bottomLeft: Radius.circular(50.0))),
              child: Column(
                children: [
                  CustomText(
                      text: 'Search anime you want',
                      color: darkmode ? Colors.white : Colors.black,
                      size: width / 15.6),
                  AddVerticalSpace(
                    height * 0.03,
                  ),
                  TextField(
                    controller: fieldText,
                    style: TextStyle(
                      color: darkmode ? Colors.white : Colors.black,
                    ),
                    cursorColor: darkmode ? Colors.white : Colors.black,
                    onSubmitted: (newVal) {
                      searchText(newVal);
                      initiateSearch(newVal);
                      clearText();
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        borderSide: BorderSide(
                          color: darkmode ? Colors.white : Colors.black,
                        ),
                      ),
                      hintStyle: const TextStyle(color: Color(0xff0B354F)),
                      label: CustomText(
                        text: 'Anime',
                        size: width / 20,
                        color: darkmode ? Colors.white : Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: darkmode ? Colors.white : Colors.black,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  userSearch == ''
                      ? Container()
                      : CustomText(
                          text: 'You Searched For :',
                          color: darkmode ? Colors.white : Colors.black,
                          size: width / 26),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                      text: userSearch,
                      color: darkmode ? Colors.white : Colors.black,
                      size: width / 22),
                ],
              ),
            ),
            AddVerticalSpace(
              height * 0.03,
            ),
            isLoading
                ? Center(
                    child: Image(
                      width: width / 1.95,
                      height: width / 1.95,
                      image: const AssetImage(
                        'images/search.gif',
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.6,
                          crossAxisCount:
                              networking.searchAnimeResponse.isEmpty ? 1 : 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount: networking.totalResults == 0
                            ? 1
                            : networking.searchAnimeResponse.length + 1,
                        itemBuilder: (context, index) {
                          if (networking.totalResults == 0) {
                            return CustomText(
                                text: 'No results found, try another keywords',
                                color: darkmode ? Colors.white : Colors.black,
                                size: width / 19.5);
                          }
                          if (index < networking.searchAnimeResponse.length) {
                            return Hero(
                              tag: 'poster$index',
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return AnimeInfoPage(
                                            networking.searchAnimeResponse,
                                            index);
                                      }),
                                    );
                                  });
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
                                            image: NetworkImage(networking
                                                    .searchAnimeResponse[index]
                                                ['images']['jpg']['image_url']),
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
                                          text: networking
                                              .searchAnimeResponse[index]
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
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
