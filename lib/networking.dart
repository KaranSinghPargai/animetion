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
    print('Search Anime called');
    http.Response apiResponse;
    apiResponse = await http.get(Uri.parse('$jikanApiURL/anime?q=$searchAnime'));
    print(apiResponse.statusCode);
    if (apiResponse.statusCode == 200) {
        mapResponseSearchAnime = json.decode(apiResponse.body);
        listResponseSearchAnime = mapResponseSearchAnime['data'];
        listResponse= listResponseSearchAnime;
    }
    return listResponseSearchAnime;
  }

  Future jikanApiCallTopAnime()async{
    print('Top Anime called');
    http.Response apiResponse;
    apiResponse = await http.get(Uri.parse('$jikanApiURL/top/anime'));
    print(apiResponse.statusCode);
    if(apiResponse.statusCode==200){
      mapResponseTopAnime= json.decode(apiResponse.body);
      listResponseTopAnime = mapResponseTopAnime['data'];
      listResponse=listResponseTopAnime;
    }
    print(listResponseTopAnime);
    return listResponseTopAnime;
  }

  Future jikanApiCallGetAnimeVideos(int id)async{
    print('vid fxn called');
    http.Response apiResponse;
    apiResponse =await http.get(Uri.parse('$jikanApiURL/anime/$id/videos'));
    print(id);
    print(apiResponse.statusCode);
    if(apiResponse.statusCode==200){
      print('sucess');
      mapResponse = json.decode(apiResponse.body);
      listResponse= mapResponse['data']['episodes'];
    }
    return listResponse;
  }
}