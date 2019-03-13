import "package:stock_analysis_application_ui/src/models/stock.dart";
import "package:stock_analysis_application_ui/src/common/constants/app_constants.dart";

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Stock>> getStocks(
    {String companySymbol, int pageSize, int pageNumber}) async {
  // TODO - find better way to handle query params
  String url = AppConstants.baseUrl +
      '/stocks/$companySymbol?limit=$pageSize&offset=${pageNumber * pageSize}';
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return List<Stock>.from(jsonResponse.map((x) => Stock.fromJson(x)));
  } else {
    throw Exception('Failed to load company');
  }
}
