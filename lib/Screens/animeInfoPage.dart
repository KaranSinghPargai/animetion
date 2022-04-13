import 'package:url_launcher/url_launcher.dart';
import 'package:animetion/networking.dart';
import 'package:animetion/utilities/constants.dart';
import 'package:animetion/widgets/addSpace.dart';
import 'package:animetion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:animetion/widgets/categoriesTitleText.dart';

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
    var data = widget.listResponse[widget.animeIDIndex];
    List genreBuild = widget.listResponse[widget.animeIDIndex]['genres'];
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: primary_color,
        ),
        child: Padding(
          padding: EdgeInsets.all(height(context)*0.02),
          child: ListView(
            physics: BouncingScrollPhysics(),
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
                          height: 300,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                widget.listResponse[widget.animeIDIndex]
                                    ['images']['jpg']['image_url'],
                              ),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ), //Poster
                  AddVerticalSpace(height(context)*0.03),
                  widget.listResponse[widget.animeIDIndex]['trailer']['url']==null?Container():
                  Center(
                    child:
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: accent_Color,
                          ),
                          onPressed: (){
                           launchURL(widget.listResponse[widget.animeIDIndex]['trailer']['url']);
                          },
                          child: CustomText(text: 'Watch Trailer',size: 20,color: secondary_color,),
                        ),
                    ),
                  CustomText(text: widget.listResponse[widget.animeIDIndex]['title']
                      .toString(), color: secondary_color, size: 25.0), //Title
                  AddVerticalSpace(height(context)*0.01),
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
                                  return SizedBox(
                                    height: 1,
                                    width: 0,
                                  );
                                }
                                return Chip(
                                  backgroundColor: accent_Color,
                                    label: CustomText(text: genreBuild[index]['name'],size: 15,color: secondary_color,),);
                              }, separatorBuilder: (BuildContext context, int index) { return AddHorizontalSpace(width(context)*0.01); },),
                        ),
                      )
                    ],
                  ),
                  AddVerticalSpace(height(context)*0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        size: 30,
                        color: Colors.orangeAccent,
                      ),
                      AddHorizontalSpace(width(context)*0.02),
                      widget.listResponse[widget.animeIDIndex]
                                  ['score'] ==
                              null
                          ? CustomText(text: 'N/A', color: secondary_color, size: 18)
                          : CustomText(text: widget.listResponse[widget.animeIDIndex]['score'].toString(), color: secondary_color, size: 35),
                    ],
                  ), //Rating
                  AddVerticalSpace(height(context)*0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: widget.listResponse[widget.animeIDIndex]
                                    ['episodes'] ==
                                null
                            ? CustomText(text: 'Not Aired', color: secondary_color, size: 18.0)
                            : CustomText(text:  widget.listResponse[widget.animeIDIndex]['episodes'].toString() + ' Episodes', color: secondary_color, size: 30),
                      ),
                    ],
                  ),
                  AddVerticalSpace(height(context)*0.03),
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
                                CategoryTitleText('Type'),
                                AddVerticalSpace(height(context)*0.01),
                                CategoryText(widget.listResponse[widget.animeIDIndex]['type']),
                              ],
                            ),
                          ),
                          AddHorizontalSpace(width(context)*0.01),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CategoryTitleText('Status'),
                                AddVerticalSpace(height(context)*0.01),
                                CategoryText(widget.listResponse[widget.animeIDIndex]['status']),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CategoryTitleText('Ratings'),
                                AddVerticalSpace(height(context)*0.01),
                                CategoryText(widget.listResponse[widget.animeIDIndex]
                                ['rating']),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CategoryTitleText('Duration'),
                                AddVerticalSpace(height(context)*0.01),
                                widget.listResponse[widget.animeIDIndex]
                                ['duration']==null?
                                    CategoryText('Unknown'):
                                CategoryText(widget.listResponse[widget.animeIDIndex]
                                ['duration'].toString()),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  AddVerticalSpace(height(context)*0.03),
                  ExpansionTile(
                    iconColor: secondary_color,
                    collapsedIconColor: secondary_color,
                    title: CustomText(text: 'Synopsis',color: secondary_color, size: 15.0,),
                    children: [
                      ListTile(
                        title: CategoryText(widget.listResponse[widget.animeIDIndex]['synopsis']
                            .toString(),),
                      ),
                    ],
                  ),
                  AddVerticalSpace(height(context)*0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CategoryTitleText('English name'),
                            SizedBox(height: 5.0),
                            widget.listResponse[widget.animeIDIndex]
                                        ['title_english'] ==
                                    null
                                ? CategoryText('N/A')
                                : CategoryText(widget.listResponse[widget.animeIDIndex]
                            ['title_english'].toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AddVerticalSpace(height(context)*0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CategoryTitleText('Rank'),
                            AddVerticalSpace(height(context)*0.01),
                            widget.listResponse[widget.animeIDIndex]
                                        ['rank']==
                                    null
                                ? CategoryText('No data')
                                : CategoryText(widget.listResponse[widget.animeIDIndex]
                            ['rank']
                                .toString()),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CategoryTitleText('Season'),
                           AddVerticalSpace(height(context)*0.01),
                            widget.listResponse[widget.animeIDIndex]
                                        ['season'] ==
                                    null
                                ? CategoryText('No data')
                                : CategoryText(widget.listResponse[widget.animeIDIndex]
                            ['season']),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AddVerticalSpace(height(context)*0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CategoryTitleText('Studio'),
                            AddVerticalSpace(height(context)*0.01),
                            data['studios'].isEmpty
                                ? CategoryText('Unknown')
                                : CategoryText(data['studios'][0]['name'].toString(),),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CategoryTitleText('Aired'),
                            AddVerticalSpace(height(context)*0.01),
                            data['aired']['string'] == null
                                ? CategoryText('No data')
                                : CategoryText(data['aired']['string'].toString(),),
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
