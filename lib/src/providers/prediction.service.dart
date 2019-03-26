import "package:stock_analysis_application_ui/src/models/prediction.dart";
import "package:stock_analysis_application_ui/src/common/constants/app_constants.dart";

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// TODO - get predictions json with keys as int
Future<List<Prediction>> getPredictions(String symbol) async {
  // TODO - find better way to handle query params
  Map<String, String> queryParams = {
    'symbol': symbol,
  };
  String queryString = queryParams.length > 0 ? "?" : "";
  queryParams.forEach((k, v) => queryString += k + "=" + v + "&");
  String url = AppConstants.baseUrl + '/predictions' + queryString;
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return List<Prediction>.from(
        jsonResponse['predictions'].map((x) => Prediction.fromJson(x)));
  } else {
    throw Exception('Failed to load company');
  }
}
