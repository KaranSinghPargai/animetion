import 'package:url_launcher/url_launcher.dart';
import 'package:animetion/services/networking.dart';
import 'package:animetion/utilities/constants.dart';
import 'package:animetion/widgets/addSpace.dart';
import 'package:animetion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:animetion/utilities/themeNotifier.dart';
import 'package:provider/provider.dart';

class AnimeInfoPage extends StatefulWidget {
  AnimeInfoPage(this.listResponse, this.animeIDIndex);
  List listResponse;
  int animeIDIndex;
  @override
  _AnimeInfoPageState createState() => _AnimeInfoPageState();
}

class _AnimeInfoPageState extends State<AnimeInfoPage> {
  Networking networking = Networking();
  Future launchURL(String url) async {
    if (!await launch(
      url,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkmode = Provider.of<ThemeNotifier>(context).darkMode;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var data = widget.listResponse[widget.animeIDIndex];
    List genreBuild = widget.listResponse[widget.animeIDIndex]['genres'];
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: darkmode ? darkModePrimaryColor : lightModePrimaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(height * 0.02),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'poster${widget.animeIDIndex}',
                        child: Container(
                          height: width / 1.4,
                          width: width / 1.95,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                widget.listResponse[widget.animeIDIndex]
                                    ['images']['jpg']['image_url'],
                              ),
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ), //Poster
                  AddVerticalSpace(height * 0.03),
                  widget.listResponse[widget.animeIDIndex]['trailer']['url'] ==
                          null
                      ? Container()
                      : Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: darkmode
                                  ? darkModeAccentColor
                                  : lightModeSecondaryColor,
                            ),
                            onPressed: () {
                              launchURL(widget.listResponse[widget.animeIDIndex]
                                  ['trailer']['url']);
                            },
                            child: CustomText(
                              text: 'Watch Trailer',
                              size: 20,
                              color: darkmode ? Colors.white : Colors.black,
                              customFontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                  CustomText(
                      maxLines: 5,
                      text: widget.listResponse[widget.animeIDIndex]['title']
                          .toString(),
                      color: darkmode ? Colors.white : Colors.black,
                      size: 25.0), //Title
                  AddVerticalSpace(height * 0.01),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 30.0,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: genreBuild.length,
                            itemBuilder: (context, index) {
                              if (genreBuild.isEmpty) {
                                return const SizedBox(
                                  height: 1,
                                  width: 0,
                                );
                              }
                              return Chip(
                                backgroundColor: darkmode
                                    ? darkModeAccentColor
                                    : lightModeSecondaryColor,
                                label: CustomText(
                                  text: genreBuild[index]['name'],
                                  size: 15,
                                  color: darkmode ? Colors.white : Colors.black,
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return AddHorizontalSpace(width * 0.01);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  AddVerticalSpace(height * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        size: width / 13,
                        color: Colors.orangeAccent,
                      ),
                      AddHorizontalSpace(width * 0.02),
                      widget.listResponse[widget.animeIDIndex]['score'] == null
                          ? CustomText(
                              text: 'N/A',
                              color: darkmode ? Colors.white : Colors.black,
                              size: width / 11,
                            )
                          : CustomText(
                              text: widget.listResponse[widget.animeIDIndex]
                                      ['score']
                                  .toString(),
                              color: darkmode ? Colors.white : Colors.black,
                              size: width / 11),
                    ],
                  ), //Rating
                  AddVerticalSpace(height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: widget.listResponse[widget.animeIDIndex]
                                    ['episodes'] ==
                                null
                            ? CustomText(
                                text: 'Not Aired',
                                color: darkmode ? Colors.white : Colors.black,
                                size: width / 21.8)
                            : CustomText(
                                text: widget.listResponse[widget.animeIDIndex]
                                            ['episodes']
                                        .toString() +
                                    ' Episodes',
                                color: darkmode ? Colors.white : Colors.black,
                                size: width / 18),
                      ),
                    ],
                  ),
                  AddVerticalSpace(height * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: 'Type',
                                    color:
                                        darkmode ? Colors.white : Colors.black,
                                    size: width / 32.6),
                                AddVerticalSpace(height * 0.01),
                                CustomText(
                                  text: widget.listResponse[widget.animeIDIndex]
                                      ['type'],
                                  color: darkmode ? Colors.white : Colors.black,
                                  size: width / 26,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          AddHorizontalSpace(width * 0.01),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: 'Status',
                                    color:
                                        darkmode ? Colors.white : Colors.black,
                                    size: width / 32.6),
                                AddVerticalSpace(height * 0.01),
                                CustomText(
                                  text: widget.listResponse[widget.animeIDIndex]
                                      ['status'],
                                  color: darkmode ? Colors.white : Colors.black,
                                  size: width / 26,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          AddHorizontalSpace(width * 0.01),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Ratings',
                                  color: darkmode ? Colors.white : Colors.black,
                                  size: width / 32.6,
                                ),
                                AddVerticalSpace(height * 0.01),
                                CustomText(
                                  text: widget.listResponse[widget.animeIDIndex]
                                      ['rating'],
                                  color: darkmode ? Colors.white : Colors.black,
                                  size: width / 26,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Duration',
                                  color: darkmode ? Colors.white : Colors.black,
                                  size: width / 32.6,
                                ),
                                AddVerticalSpace(height * 0.01),
                                widget.listResponse[widget.animeIDIndex]
                                            ['duration'] ==
                                        null
                                    ? CustomText(
                                        text: 'Unknown',
                                        color: darkmode
                                            ? Colors.white
                                            : Colors.black,
                                        size: width / 26,
                                      )
                                    : CustomText(
                                        text: widget
                                            .listResponse[widget.animeIDIndex]
                                                ['duration']
                                            .toString(),
                                        color: darkmode
                                            ? Colors.white
                                            : Colors.black,
                                        size: width / 26,
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  AddVerticalSpace(height * 0.03),
                  ExpansionTile(
                    initiallyExpanded: true,
                    iconColor: darkmode ? Colors.white : Colors.black,
                    collapsedIconColor: darkmode ? Colors.white : Colors.black,
                    title: CustomText(
                      text: 'Synopsis',
                      color: darkmode ? Colors.white : Colors.black,
                      size: width / 26,
                    ),
                    children: [
                      ListTile(
                        title: CustomText(
                          text: widget.listResponse[widget.animeIDIndex]
                                  ['synopsis']
                              .toString(),
                          color: darkmode ? Colors.white : Colors.black,
                          size: width / 26,
                          maxLines: 100,
                        ),
                      ),
                    ],
                  ),
                  AddVerticalSpace(height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'English name',
                              color: darkmode ? Colors.white : Colors.black,
                              size: width / 32.6,
                              maxLines: 5,
                            ),
                            const SizedBox(height: 5.0),
                            widget.listResponse[widget.animeIDIndex]
                                        ['title_english'] ==
                                    null
                                ? CustomText(
                                    text: 'N/A',
                                    color:
                                        darkmode ? Colors.white : Colors.black,
                                    size: width / 26,
                                  )
                                : CustomText(
                                    text: widget
                                        .listResponse[widget.animeIDIndex]
                                            ['title_english']
                                        .toString(),
                                    color:
                                        darkmode ? Colors.white : Colors.black,
                                    size: width / 26,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AddVerticalSpace(height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Rank',
                              color: darkmode ? Colors.white : Colors.black,
                              size: width / 32.6,
                            ),
                            AddVerticalSpace(height * 0.01),
                            widget.listResponse[widget.animeIDIndex]['rank'] ==
                                    null
                                ? CustomText(
                                    text: 'No data',
                                    color:
                                        darkmode ? Colors.white : Colors.black,
                                    size: width / 26,
                                  )
                                : CustomText(
                                    text: widget
                                        .listResponse[widget.animeIDIndex]
                                            ['rank']
                                        .toString(),
                                    size: width / 26,
                                    color:
                                        darkmode ? Colors.white : Colors.black,
                                  ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Season',
                              size: width / 32.6,
                              color: darkmode ? Colors.white : Colors.black,
                            ),
                            AddVerticalSpace(height * 0.01),
                            widget.listResponse[widget.animeIDIndex]
                                        ['season'] ==
                                    null
                                ? CustomText(
                                    text: 'No data',
                                    size: width / 26,
                                    color:
                                        darkmode ? Colors.white : Colors.black,
                                  )
                                : CustomText(
                                    text:
                                        widget.listResponse[widget.animeIDIndex]
                                            ['season'],
                                    size: width / 26,
                                    color:
                                        darkmode ? Colors.white : Colors.black,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AddVerticalSpace(height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Studio',
                              size: width / 32.6,
                              color: darkmode ? Colors.white : Colors.black,
                            ),
                            AddVerticalSpace(height * 0.01),
                            data['studios'].isEmpty
                                ? CustomText(
                                    text: 'Unknown',
                                    size: width / 26,
                                    color:
                                        darkmode ? Colors.white : Colors.black,
                                  )
                                : CustomText(
                                    text: data['studios'][0]['name'].toString(),
                                    size: width / 26,
                                    color:
                                        darkmode ? Colors.white : Colors.black,
                                  ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Aired',
                              size: width / 32.6,
                              color: darkmode ? Colors.white : Colors.black,
                            ),
                            AddVerticalSpace(height * 0.01),
                            data['aired']['string'] == null
                                ? CustomText(
                                    text: 'No data',
                                    size: width / 26,
                                    color:
                                        darkmode ? Colors.white : Colors.black,
                                  )
                                : CustomText(
                                    text: data['aired']['string'].toString(),
                                    size: width / 26,
                                    color:
                                        darkmode ? Colors.white : Colors.black,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
