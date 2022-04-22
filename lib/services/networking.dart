import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking{
  String jikanApiURL = 'https://api.jikan.moe/v4';
  Map mapResponseTopAnime={};
  Map mapResponseSearchAnime={};
  List listResponseTopAnime=[];
  List listResponseSearchAnime=[];
  Map mapResponseTopCharacters={};
  List listResponseTopCharacters=[];

  Future jikanApiCallSearchedAnime(String searchAnime) async {
    http.Response apiResponse;
    apiResponse = await http.get(Uri.parse('$jikanApiURL/anime?q=$searchAnime'));
    if (apiResponse.statusCode == 200) {
        mapResponseSearchAnime = json.decode(apiResponse.body);
        listResponseSearchAnime = mapResponseSearchAnime['data'];
    }
    return listResponseSearchAnime;
  }

  Future jikanApiCallTopAnime()async{
    http.Response apiResponse;
    apiResponse = await http.get(Uri.parse('$jikanApiURL/top/anime'));
    if(apiResponse.statusCode==200){
      mapResponseTopAnime= json.decode(apiResponse.body);
      listResponseTopAnime = mapResponseTopAnime['data'];
    }
    return listResponseTopAnime;
  }

  Future jikanApiCallTopCharacters()async{
    http.Response apiResponse;
    apiResponse =await http.get(Uri.parse('$jikanApiURL/top/characters'));
    if(apiResponse.statusCode==200){
      mapResponseTopCharacters= json.decode(apiResponse.body);
      listResponseTopCharacters = mapResponseTopCharacters['data'];
    }
    return listResponseTopCharacters;
  }
}