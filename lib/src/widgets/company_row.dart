import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';
import 'package:stock_analysis_application_ui/src/screens/stock_screen.dart';

class CompanyRow extends StatelessWidget {
  final Company company;
  CompanyRow(this.company);
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
                new StockScreen(company: company));
        Navigator.of(context).push(route);
      },
      child: new Card(
        elevation: 4.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: new GestureDetector(
          onTap: () {
            var route = MaterialPageRoute(
                builder: (BuildContext context) =>
                    StockScreen(company: company));
            Navigator.of(context).push(route);
          },
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
                  style: TextStyle(fontSize: 10.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
