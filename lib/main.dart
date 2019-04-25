import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/screens/company/company_screen.dart';
import 'package:stock_analysis_application_ui/src/providers/company.service.dart';
import "package:stock_analysis_application_ui/src/models/company.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCompanies(),
      initialData: List<Company>(),
      builder: (BuildContext context, AsyncSnapshot<List<Company>> snapshot) {
        return MaterialApp(
          title: 'Stock App',
          theme: ThemeData.light(),
          home: CompanyScreen(companies: snapshot.data),
        );
      },
    );
  }
}
