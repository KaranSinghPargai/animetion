import 'package:animetion/Screens/animeHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:animetion/Screens/home_Screen.dart';

const String jikanApiURL = 'https://api.jikan.moe/v4';
void main() {
  runApp(Animetion());
}

class Animetion extends StatelessWidget {

  // List listResponse = [];
  // Map mapResponse={};
  //
  // Future jikanApiCall() async {
  //   http.Response apiResponse;
  //   apiResponse = await http.get(Uri.parse('$jikanApiURL/top/characters'));
  //   print(apiResponse);
  //   if (apiResponse.statusCode == 200) {
  //     setState(() {
  //       mapResponse = json.decode(apiResponse.body);
  //       listResponse = mapResponse['data'];
  //     });
  //   }
  // }
  //
  // @override
  // void initState() {
  //   jikanApiCall();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:HomeScreen(),
    );
  }
}
// Scaffold(
// backgroundColor: Colors.lightBlueAccent,
// body: ListView.builder(
// scrollDirection: Axis.horizontal,
// itemCount: listResponse.isNotEmpty? listResponse.length:0,
// itemBuilder: (context, index) {
// return Container(
// height: 250,
// width: 175,
// child: listResponse.isNotEmpty?Image.network(
// listResponse[index]['images']['jpg']['image_url']):Container(),
// );
// }
// ),
// ),