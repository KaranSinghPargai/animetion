import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking{
  String jikanApiURL = 'https://api.jikan.moe/v4';
  Map mapResponse={};
  List listResponse=[];

  Future jikanApiCall(String searchAnime) async {
    http.Response apiResponse;
    apiResponse = await http.get(Uri.parse('$jikanApiURL/anime?q=$searchAnime'));
    print(apiResponse.statusCode);
    if (apiResponse.statusCode == 200) {
        mapResponse = json.decode(apiResponse.body);
        listResponse = mapResponse['data'];
    }
  }

  Future jikanApiCallTopAnime()async{
    http.Response apiResponse;
    apiResponse = await http.get(Uri.parse('$jikanApiURL/top/anime'));
    print(apiResponse.statusCode);
    if(apiResponse.statusCode==200){
      mapResponse= json.decode(apiResponse.body);
      listResponse = mapResponse['data'];
    }
    return listResponse;
  }

  Future jikanApiCallGetAnimeVideos(int id)async{
    http.Response apiResponse;
    apiResponse =await http.get(Uri.parse('$jikanApiURL/$id/videos'));
    print(apiResponse.statusCode);
    if(apiResponse.statusCode==200){
      mapResponse = json.decode(apiResponse.body);
      listResponse= mapResponse['data'];
    }
  }
}