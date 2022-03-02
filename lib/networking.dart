import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking{
  String jikanApiURL = 'https://api.jikan.moe/v4';
  Map mapResponse={};
  List listResponse=[];

  Future jikanApiCallSearchedAnime(String searchAnime) async {
    print('Search Anime called');
    http.Response apiResponse;
    apiResponse = await http.get(Uri.parse('$jikanApiURL/anime?q=$searchAnime'));
    print(apiResponse.statusCode);
    if (apiResponse.statusCode == 200) {
        mapResponse = json.decode(apiResponse.body);
        listResponse = mapResponse['data'];
    }
    return listResponse;
  }

  Future jikanApiCallTopAnime()async{
    print('Top Anime called');
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