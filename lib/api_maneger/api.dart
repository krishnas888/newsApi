
import 'dart:convert';

import 'package:food/api_maneger/stream.dart';
import 'package:food/model/testla.dart';
import 'package:http/http.dart' as http;
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

