import "package:stock_analysis_application_ui/src/models/company.dart";
import "package:stock_analysis_application_ui/src/constants/app_constants.dart";
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Company>> getCompanies() async {
  final response = await http.get(AppConstants.baseUrl + '/companies');
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return List<Company>.from(jsonResponse.map((x) => Company.fromJson(x)));
  } else {
    throw Exception('Failed to load company');
  }
}
