import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/widgets/company_row_widget.dart';
import 'package:stock_analysis_application_ui/src/providers/company.service.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';

class CompanyScreen extends StatefulWidget {
  @override
  State<CompanyScreen> createState() {
    return CompanyScreenState();
  }
}

class CompanyScreenState extends State<CompanyScreen> {
  List<Company> companies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Analysis App"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(border: Border.all(width: 1.0)),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                textAlign: TextAlign.left,
                controller: TextEditingController(),
              ),
            ),
            Flexible(
              child: FutureBuilder(
                future: getCompanies(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Company>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) =>
                            CompanyRowWidget(
                              company: snapshot.data[index],
                              index: index,
                            ),
                        itemCount: snapshot.data.length,
                      );
                    default:
                      return Text("Loading...");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
