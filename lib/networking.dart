import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking{
  String jikanApiURL = 'https://api.jikan.moe/v4';
  Map mapResponse={};
  List listResponse=[];
  Map mapResponseTopAnime={};
  Map mapResponseSearchAnime={};
  List listResponseTopAnime=[];
  List listResponseSearchAnime=[];

  Future jikanApiCallSearchedAnime(String searchAnime) async {
    http.Response apiResponse;
    apiResponse = await http.get(Uri.parse('$jikanApiURL/anime?q=$searchAnime'));
    if (apiResponse.statusCode == 200) {
        mapResponseSearchAnime = json.decode(apiResponse.body);
        listResponseSearchAnime = mapResponseSearchAnime['data'];
        listResponse= listResponseSearchAnime;
    }
    return listResponseSearchAnime;
  }

  Future jikanApiCallTopAnime()async{
    http.Response apiResponse;
    apiResponse = await http.get(Uri.parse('$jikanApiURL/top/anime'));
    if(apiResponse.statusCode==200){
      mapResponseTopAnime= json.decode(apiResponse.body);
      listResponseTopAnime = mapResponseTopAnime['data'];
      listResponse=listResponseTopAnime;
    }
    return listResponseTopAnime;
  }
}