import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';
import 'package:stock_analysis_application_ui/src/models/stock.dart';
import 'package:stock_analysis_application_ui/src/models/prediction.dart';

import 'package:stock_analysis_application_ui/src/widgets/stock_row_widget.dart';
import 'package:stock_analysis_application_ui/src/widgets/keep_alive_future_builder.dart';
import 'package:stock_analysis_application_ui/src/widgets/prediction_widget.dart';

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
  List<Prediction> predictions;
  @override
  void initState() {
    super.initState();
    // getPredictions(widget.company.symbol)
    //     .then((predictions) => {this.predictions = predictions});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Page"),
      ),
      body: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0),
              height: MediaQuery.of(context).size.height * 0.6,
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
          DropdownButton<String>(
            value: "One",
            onChanged: (String newValue) {},
            items: <String>['One', 'Two', 'Free', 'Four']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              height: MediaQuery.of(context).size.height * 0.2,
              child: FutureBuilder(
                future: getPredictions(widget.company.symbol),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Prediction>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('Press button to start.');
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Text('Awaiting result...');
                    case ConnectionState.done:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PredictionWidget(snapshot.data[index]);
                        },
                      );
                  }
                },
              )),
        ],
      ),
    );
  }

  Widget _buildPage(List<Stock> page) {
    return ListView(
        reverse: true,
        shrinkWrap: true,
        primary: false,
        children: page.map((Stock stock) {
          return StockRowWidget(stock);
        }).toList());
  }
}
