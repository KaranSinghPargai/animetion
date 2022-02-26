import 'package:animetion/networking.dart';
import 'package:flutter/material.dart';
import 'animeHomeScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            onSubmitted:(newVal){
              setState(() {
                Networking networking = Networking();
                networking.jikanApiCall(newVal);
              });
            },
            decoration: const InputDecoration(
              hintText: 'Search Anime Here',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
