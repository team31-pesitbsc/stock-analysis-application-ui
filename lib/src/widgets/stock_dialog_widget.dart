import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/stock.dart';

class StockDialogWidget extends StatelessWidget {
  final Stock stock;

  StockDialogWidget(this.stock);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        child: Row(
          children: <Widget>[
            Icon(Icons.calendar_today),
            Padding(
              padding: EdgeInsets.all(4.0),
            ),
            Text(stock.date.toString().substring(0, 10))
          ],
        ),
      ),
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Open : " + stock.open.toString(),
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              "Close : " + stock.close.toString(),
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              "High : " + stock.high.toString(),
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              "Low : " + stock.low.toString(),
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              "Volume : " + stock.volume.toString(),
              style: TextStyle(fontSize: 25.0),
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.2,
      ),
      actions: <Widget>[],
    );
  }
}
