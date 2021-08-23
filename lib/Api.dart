import 'dart:convert';

import 'package:demo/Model/api_model.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  Future<BreakingBadModel> getAllCharacters() async {
    var client = http.Client();
    var breakingBad;

    try {
      var response = await client
          .get(Uri.parse('https://www.breakingbadapi.com/api/characters'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        breakingBad = BreakingBadModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return breakingBad;
    }

    return breakingBad;
  }
}
