import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';
import 'package:stock_analysis_application_ui/src/screens/stock/stock_screen.dart';

class CompanyRowWidget extends StatelessWidget {
  final Company company;
  final int index;
  CompanyRowWidget({this.company, this.index});

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
                    child: Text(company.symbol.substring(0, 1)),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
              ),
              Column(
                children: <Widget>[
                  Text(
                    (company.name.length <= 15)
                        ? company.name
                        : company.name.substring(0, 20) + "...",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Text(
                    company.symbol,
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
