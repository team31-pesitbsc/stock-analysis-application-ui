import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';
import 'package:stock_analysis_application_ui/src/models/stock.dart';

import 'package:stock_analysis_application_ui/src/widgets/stock_row.dart';
import 'package:stock_analysis_application_ui/src/widgets/keep_alive_future_builder.dart';

import 'package:stock_analysis_application_ui/src/providers/stock.service.dart';
import 'package:stock_analysis_application_ui/src/providers/prediction.service.dart';

import 'package:stock_analysis_application_ui/src/common/constants/app_constants.dart';

class StockScreen extends StatefulWidget {
  final Company company;

  StockScreen({Key key, this.company}) : super(key: key);
  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  void initState() {
    super.initState();
    getPredictions(widget.company.symbol).then((something) => {print("done")});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Page"),
      ),
      body: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: MediaQuery.of(context).size.height * 0.65,
          child: ListView.builder(
              reverse: true,
              itemBuilder: (context, pageNumber) {
                return KeepAliveFutureBuilder(
                  future: getStocks(
                      symbol: widget.company.symbol,
                      pageSize: AppConstants.pageSize,
                      pageNumber: pageNumber),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return SizedBox(
                            height: MediaQuery.of(context).size.height * 2,
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: CircularProgressIndicator()));
                      case ConnectionState.active:
                        break;
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return this._buildPage(snapshot.data);
                        }
                    }
                  },
                );
              })),
    );
  }

  Widget _buildPage(List<Stock> page) {
    return ListView(
        reverse: true,
        shrinkWrap: true,
        primary: false,
        children: page.map((Stock stock) {
          return StockRow(stock);
        }).toList());
  }
}
