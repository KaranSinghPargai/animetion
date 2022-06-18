import 'package:animetion/Screens/animeInfoPage.dart';
import 'package:animetion/services/networking.dart';
import 'package:animetion/utilities/constants.dart';
import 'package:animetion/widgets/addSpace.dart';
import 'package:animetion/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

Networking networking = Networking();

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = true;
  int page = 2;
  final ScrollController _scrollController = ScrollController();
  bool showFAB = false;
  bool hasMore = true;
  String userSearch = '';
  void initiateSearch(String search) async {
    if (page >= 3) {
      page = 2;
    }
    isLoading = true;
    await networking.jikanApiCallSearchedAnime(search);
    setState(() {
      isLoading = false;
    });
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
        setState(() {
          networking.jikanApiCallSearchedAnimeByPage(userSearch, page);
          networking.searchAnimeResponse;
          showFAB = true;
          page++;
          // if (networking.newItemForSearch.length <= 25) {
          //   hasMore = false;
          // }
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
      backgroundColor: primary_color,
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
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: height * 0.02, left: width * 0.02, right: width * 0.02),
              height: height * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: accent_Color,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50.0),
                      bottomLeft: Radius.circular(50.0))),
              child: Column(
                children: [
                  CustomText(
                      text: 'Search anime you want',
                      color: secondary_color,
                      size: 25.0),
                  AddVerticalSpace(
                    height * 0.03,
                  ),
                  TextField(
                    controller: fieldText,
                    style: TextStyle(
                      color: secondary_color,
                      fontFamily: 'Asap',
                    ),
                    cursorColor: secondary_color,
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
                          color: secondary_color,
                        ),
                      ),
                      hintStyle: const TextStyle(
                          color: Color(0xff0B354F), fontFamily: 'Asap'),
                      label: CustomText(
                        text: 'Anime',
                        size: 20,
                        color: secondary_color,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: secondary_color,
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
                          color: secondary_color,
                          size: 15),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                      text: userSearch, color: secondary_color, size: 18.0),
                ],
              ),
            ),
            AddVerticalSpace(
              height * 0.03,
            ),
            isLoading
                ? const Center(
                    child: Image(
                      width: 200,
                      height: 200,
                      image: AssetImage(
                        'images/search.gif',
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.6,
                          crossAxisCount:
                              networking.searchAnimeResponse.isEmpty ? 1 : 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount: networking.searchAnimeResponse.length + 1,
                        itemBuilder: (context, index) {
                          if (networking.searchAnimeResponse.isEmpty) {
                            return CustomText(
                                text: 'No results found, try another keywords',
                                color: secondary_color,
                                size: 20);
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
                                    Expanded(
                                      flex: 2,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: CustomText(
                                          text: networking
                                              .searchAnimeResponse[index]
                                                  ['title']
                                              .toString(),
                                          size: 18.0,
                                          color: secondary_color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return hasMore
                                ? Center(child: CircularProgressIndicator())
                                : Text('End of results');
                          }
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
