import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';

class StockScreen extends StatefulWidget {
  final Company company;

  StockScreen({Key key, this.company}) : super(key: key);
  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Stock Page"),
      ),
      body: Text("${widget.company.companyName}"),
    );
  }
}
