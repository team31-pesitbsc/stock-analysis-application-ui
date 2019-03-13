import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';
import 'package:stock_analysis_application_ui/src/screens/stock_screen.dart';

class CompanyRow extends StatelessWidget {
  final Company company;
  final int index;
  CompanyRow({this.company, this.index});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var route = MaterialPageRoute(
            builder: (BuildContext context) => StockScreen(company: company));
        Navigator.of(context).push(route);
      },
      child: Card(
        elevation: 2.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  CircleAvatar(
                    child: Text(company.companySymbol.substring(0, 1)),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
              ),
              Column(
                children: <Widget>[
                  Text(
                    company.companyName,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    company.companySymbol,
                    style: TextStyle(fontSize: 10.0),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
