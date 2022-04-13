import 'package:animetion/Screens/animeInfoPage.dart';
import 'package:animetion/networking.dart';
import 'package:animetion/utilities/constants.dart';
import 'package:animetion/widgets/addSpace.dart';
import 'package:animetion/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

Networking networking = Networking();

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = true;

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
          children: [
            Container(
              padding: EdgeInsets.only(top: height(context)*0.02, left: width(context)*0.02,right: width(context)*0.02),
                height: height(context)*0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: accent_Color,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50.0),
                        bottomLeft: Radius.circular(50.0))),
                child: Column(
                  children: [
                    CustomText(
                        text: 'Search anime you want',
                        color: secondary_color,
                        size: 25.0),
                    AddVerticalSpace(
                      height(context) * 0.03,
                    ),
                    TextField(
                      style: TextStyle(
                        color: secondary_color,
                        fontFamily: 'Asap',
                      ),
                      cursorColor: Color(0xffE9A6A6),
                      onSubmitted: (newVal) {
                        initiateSearch(newVal);
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          borderSide: BorderSide(
                            color: secondary_color,
                          ),
                        ),
                        hintStyle:
                        TextStyle(color: Color(0xff0B354F), fontFamily: 'Asap'),
                        label: CustomText(
                          text: 'Anime',
                          size: 20,
                          color: secondary_color,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: secondary_color,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),),
            AddVerticalSpace(
              height(context) * 0.03,
            ),
            isLoading
                ? Center(child: Image(width: 200,height: 200, image: AssetImage('images/search.gif',),),)
                : Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(context)*0.02),
                  child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.75,
                        crossAxisCount: networking.listResponseSearchAnime.isEmpty?1:2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemCount: networking.listResponseSearchAnime.isEmpty
                          ? 1
                          : networking.listResponseSearchAnime.length,
                      itemBuilder: (context, index) {
                        if(networking.listResponseSearchAnime.isEmpty){
                          return CustomText(text: 'No results found, try with another keywords',size: 25.0,color: secondary_color,);
                        }
                        else{
                        return Hero(
                          tag: 'poster$index',
                          child: Stack(
                            children: [
                              Container(
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
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: primary_color.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5.0),
                                        bottomRight: Radius.circular(
                                          5.0,
                                        ),
                                      ),
                                    ),
                                    child: CustomText(
                                      text: networking.listResponseSearchAnime[index]['title'].toString(),
                                      size: 18.0,
                                      color: secondary_color,
                                    ),
                                  ),),
                              ),
                            ],
                          ),
                        );}
                      }),
                ),
          ],
        ),
      ),
    );
  }
}
