import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  String jikanApiURL = 'https://api.jikan.moe/v4';
  Map _mapResponseTopAnime = {};
  Map _mapResponseSearchAnime = {};
  List topAnimeResponse = [];
  List searchAnimeResponse = [];
  Map _mapResponseTopCharacters = {};
  List topCharactersResponse = [];
  List newItemForSearch = [];
  bool hasNextPage = true;
  Future jikanApiCallSearchedAnime(String searchAnime) async {
    http.Response apiResponse;
    apiResponse =
        await http.get(Uri.parse('$jikanApiURL/anime?q=$searchAnime'));
    if (apiResponse.statusCode == 200) {
      _mapResponseSearchAnime = json.decode(apiResponse.body);
      searchAnimeResponse = _mapResponseSearchAnime['data'];
      hasNextPage = _mapResponseSearchAnime['pagination']['has_next_page'];
      print('has next page : $hasNextPage');
    }
    return searchAnimeResponse;
  }

  Future jikanApiCallSearchedAnimeByPage(String searchAnime, int page) async {
    http.Response apiResponse;
    apiResponse = await http
        .get(Uri.parse('$jikanApiURL/anime?q=$searchAnime&page=$page'));
    if (apiResponse.statusCode == 200) {
      _mapResponseSearchAnime = json.decode(apiResponse.body);
      hasNextPage = _mapResponseSearchAnime['pagination']['has_next_page'];
      print('has next page : $hasNextPage');
      final List newItems = _mapResponseSearchAnime['data'];
      newItemForSearch = newItems;
      print('page $page for $searchAnime');
      searchAnimeResponse.addAll(newItems);
    }
    return searchAnimeResponse;
  }

  Future jikanApiCallTopAnime() async {
    http.Response apiResponse;
    apiResponse = await http.get(Uri.parse('$jikanApiURL/top/anime'));
    if (apiResponse.statusCode == 200) {
      _mapResponseTopAnime = json.decode(apiResponse.body);
      topAnimeResponse = _mapResponseTopAnime['data'];
    }
    return topAnimeResponse;
  }

  Future jikanApiCallTopCharacters() async {
    http.Response apiResponse;
    apiResponse = await http.get(Uri.parse('$jikanApiURL/top/characters'));
    if (apiResponse.statusCode == 200) {
      _mapResponseTopCharacters = json.decode(apiResponse.body);
      topCharactersResponse = _mapResponseTopCharacters['data'];
    }
    return topCharactersResponse;
  }

  Future jikanApiCallTopAnimeByPage(int page) async {
    http.Response apiResponse;
    apiResponse =
        await http.get(Uri.parse('$jikanApiURL/top/anime?&page=$page'));

    if (apiResponse.statusCode == 200) {
      print('page $page fetched');
      _mapResponseTopAnime = json.decode(apiResponse.body);
      final List newItems = _mapResponseTopAnime['data'];
      topAnimeResponse.addAll(newItems);
    }
    return topAnimeResponse;
  }
}
