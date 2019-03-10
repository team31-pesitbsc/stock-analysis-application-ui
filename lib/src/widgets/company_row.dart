import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';

class CompanyRow extends StatelessWidget {
  final Company company;
      // Company(companyName: "Infosys", companySymbol: "INFY");

  CompanyRow(this.company);
  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: new Container(
        padding: EdgeInsets.all(8.0),
        child: new Row(
          children: <Widget>[
            new CircleAvatar(
              child: new Text('A'),
            ),
            new Padding(
              padding: EdgeInsets.only(right: 10),
            ),
            new Text(
              company.companyName,
              style: TextStyle(fontSize: 20.0),
            ),
            new Text(
              company.companySymbol,
              style: TextStyle(
                fontSize: 10.0
              ),
            )
          ],
        ),


      ),
    );
  }
}
