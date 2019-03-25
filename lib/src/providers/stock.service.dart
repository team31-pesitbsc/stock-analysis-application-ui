import "package:stock_analysis_application_ui/src/models/stock.dart";
import "package:stock_analysis_application_ui/src/common/constants/app_constants.dart";

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Stock>> getStocks(
    {String symbol, int pageSize, int pageNumber}) async {
  // TODO - find better way to handle query params
  Map<String, String> queryParams = {
    'symbol': symbol,
    'limit': pageSize.toString(),
    'offset': (pageNumber * pageSize).toString()
  };
  String queryString = queryParams.length > 0 ? "?" : "";
  queryParams.forEach((k, v) => queryString += k + "=" + v + "&");
  String url = AppConstants.baseUrl + '/stocks' + queryString;
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return List<Stock>.from(
        jsonResponse['stocks'].map((x) => Stock.fromJson(x)));
  } else {
    throw Exception('Failed to load company');
  }
}
