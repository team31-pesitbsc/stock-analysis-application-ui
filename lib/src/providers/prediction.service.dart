import "package:stock_analysis_application_ui/src/models/prediction.dart";
import "package:stock_analysis_application_ui/src/common/constants/app_constants.dart";

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Prediction>> getPredictions(
    String companySymbol, int limit, int offset) async {
  // TODO - find better way to handle query params
  String url = AppConstants.baseUrl + '/predictions/$companySymbol';
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return List<Prediction>.from(
        jsonResponse.map((x) => Prediction.fromJson(x)));
  } else {
    throw Exception('Failed to load company');
  }
}
