import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/widgets/company_row.dart';
import 'package:stock_analysis_application_ui/src/providers/company.service.dart';

class CompanyScreen extends StatefulWidget {
  @override
  State<CompanyScreen> createState() {
    return CompanyScreenState();
  }
}

class CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Analysis App"),
      ),
      body: Container(
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
              itemBuilder: (BuildContext context, int index) => CompanyRow(
                    company: snapshot.data[index],
                    index: index,
                  ),
              itemCount: snapshot.data.length,
            );
          }
        },
      )),
    );
  }
}
