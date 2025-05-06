
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapi/api_maneger/stream.dart';

import '../model/testla.dart';
class API_Maneger{
  Future<Testla>? getNews() async {
    var client = http.Client();
    var newsTestla=null;
    try {
      var response= await client.get(Uri.parse(Strings.news_url));
      if(response.statusCode==200){
        var jsonString =response.body;
        var jsonMap = json.decode(jsonString);

        newsTestla= Testla.fromJson(jsonMap);
      }
    } catch (e) {
      return newsTestla;
    }
    return newsTestla;
  }
}

