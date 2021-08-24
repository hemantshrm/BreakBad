import 'dart:convert';

import 'package:demo/Model/api_model.dart';
import 'package:http/http.dart' as http;

// class ApiManager {
//   Future<List<BreakingBadModel>> getAllCharacters() async {
//     var client = http.Client();
//     var breakingBad;
//
//     try {
//       var response = await client
//           .get(Uri.parse('https://www.breakingbadapi.com/api/characters'));
//       if (response.statusCode == 200) {
//         var jsonString = response.body;
//         var jsonMap = json.decode(jsonString);
//         // List<String> breakingBad = new List<String>.from(jsonMap);
//         //breakingBad = BreakingBadModel.fromJson(jsonMap);
//         // print(jsonMap);
//         breakingBad = jsonMap<List<BreakingBadModel>, List<dynamic>>(
//             (jsonMap) => _parseItemListFromJsonArray(
//                   jsonMap,
//                   (jsonMap) => BreakingBadModel.fromJson(jsonMap),
//                 ));
//       }
//     } catch (Exception) {
//       print(Exception);
//     }
//
//     return breakingBad;
//   }
//
//   static List<T> _parseItemListFromJsonArray<T>(
//     List<dynamic> jsonArray,
//     T Function(dynamic object) mapper,
//   ) =>
//       jsonArray.map(mapper).toList();
// }

import 'dart:io';

class ApiManager {
  static Future<List<BreakingBadModel>> getAllCharacters() async => http
      .get(
        _ApiUrlBuilder.characterList(),
      )
      .mapFromResponse<List<BreakingBadModel>, List<dynamic>>(
        (jsonArray) => _parseItemListFromJsonArray(
          jsonArray,
          (jsonObject) => BreakingBadModel.fromJson(jsonObject),
        ),
      );

  static List<T> _parseItemListFromJsonArray<T>(
    List<dynamic> jsonArray,
    T Function(dynamic object) mapper,
  ) =>
      jsonArray.map(mapper).toList();
}

class _ApiUrlBuilder {
  static const _baseUrl = 'https://www.breakingbadapi.com/api/';
  static const _charactersResource = 'characters/';

  static Uri characterList() => Uri.parse('$_baseUrl$_charactersResource');

  // static String _buildSearchTermQuery(String searchTerm) =>
  //     searchTerm != null && searchTerm.isNotEmpty
  //         ? '&name=${searchTerm.replaceAll(' ', '+').toLowerCase()}'
  //         : '';
}

extension on Future<http.Response> {
  Future<R> mapFromResponse<R, T>(R Function(T) jsonParser) async {
    try {
      final response = await this;
      if (response.statusCode == 200) {
        return jsonParser(jsonDecode(response.body));
      } else {
        throw GenericHttpException();
      }
    } on SocketException {
      throw NoConnectionException();
    }
  }
}

class GenericHttpException implements Exception {}

class NoConnectionException implements Exception {}
