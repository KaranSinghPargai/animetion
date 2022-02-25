import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String jikanApiURL = 'https://api.jikan.moe/v4';
void main() {
  runApp(Animetion());
}

class Animetion extends StatefulWidget {
  @override
  _AnimetionState createState() => _AnimetionState();
}

class _AnimetionState extends State<Animetion> {
  List listResponse=[];
  Future jikanApiCall() async {
    http.Response apiResponse;
    apiResponse = await http.get(Uri.parse('$jikanApiURL/top/characters'));
    print(apiResponse);
    if (apiResponse.statusCode == 200) {
      setState(() {
        listResponse = json.decode(apiResponse.body);
      });
    }
  }

  @override
  void initState() {
    jikanApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(itemBuilder: (context, index) {
          return Container(
            child: Row(
              children: [
                Image.network(listResponse['data'][index]['image']['image_url']),
              ],
            ),
          );
        }
        itemCount:listResponse.isNotEmpty? listResponse.length: 0,
        ),
    );
  }
