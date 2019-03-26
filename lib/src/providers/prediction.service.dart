import "package:stock_analysis_application_ui/src/models/prediction.dart";
import "package:stock_analysis_application_ui/src/common/constants/app_constants.dart";

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// TODO - get predictions json with keys as int
Future<Map<String, Map<int, Map<int, Prediction>>>> getPredictions(
    String symbol) async {
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
    Map<String, Map<int, Map<int, Prediction>>> predictions = {};
    AppConstants.CLASSIFIERS.forEach((classifier) => {
          predictions[classifier] = {},
          AppConstants.TRADING_WINDOWS.forEach((tradingWindow) => {
                predictions[classifier][tradingWindow] = {},
                AppConstants.FORWARD_DAYS.forEach((forwardDay) => {
                      predictions[classifier][tradingWindow][forwardDay] =
                          Prediction.fromJson(jsonResponse['predictions']
                                  [classifier][tradingWindow.toString()]
                              [forwardDay.toString()])
                    })
              })
        });
    return predictions;
  } else {
    throw Exception('Failed to load company');
  }
}
