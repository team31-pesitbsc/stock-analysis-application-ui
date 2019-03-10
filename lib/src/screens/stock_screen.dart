import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';
import 'package:stock_analysis_application_ui/src/widgets/stock_row.dart';
import 'package:stock_analysis_application_ui/src/providers/stock.service.dart';

class StockScreen extends StatefulWidget {
  final Company company;

  StockScreen({Key key, this.company}) : super(key: key);
  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Page"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getStocks(widget.company.companySymbol, 100, 0),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (_, int index) => StockRow(snapshot.data[index]),
                itemCount: snapshot.data.length,
              );
            }
          },
        ),
      ),
    );
  }
}
