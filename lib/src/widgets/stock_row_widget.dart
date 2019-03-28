import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/stock.dart';
import 'package:stock_analysis_application_ui/src/widgets/stock_dialog_widget.dart';

class StockRowWidget extends StatelessWidget {
  final Stock stock;
  StockRowWidget(this.stock);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.calendar_today),
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
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return StockDialogWidget(stock);
            });
      },
    );
  }
}