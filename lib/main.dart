import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/widgets/company_row.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';
import 'package:stock_analysis_application_ui/src/providers/company.service.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(new MaterialApp(
      home: new AppHome(),
    ));

class AppHome extends StatefulWidget {
  @override
  State<AppHome> createState() {
    return new AppState();
  }
}

class AppState extends State<AppHome> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("List of companies"),
      ),
      body: new Container(
          child: FutureBuilder(
        future: getCompanies(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text("loading"),
              ),
            );
          } else {
            return ListView.builder(
              itemBuilder: (_, int index) => CompanyRow(snapshot.data[index]),
              itemCount: snapshot.data.length,
            );
          }
        },
      )),
    );
  }
}
