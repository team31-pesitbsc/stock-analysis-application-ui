import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/stock.dart';

class StockRow extends StatelessWidget {
  final Stock stock;
  StockRow(this.stock);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.arrow_drop_down_circle),
            Padding(
              padding: EdgeInsets.only(right: 10),
            ),
            Text(
              stock.date.toString(),
              style: TextStyle(fontSize: 10.0),
            ),
          ],
        ),
      ),
    );
  }
}
