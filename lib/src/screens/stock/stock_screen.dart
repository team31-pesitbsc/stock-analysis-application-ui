import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';

import 'package:stock_analysis_application_ui/src/models/stock.dart';
import 'package:stock_analysis_application_ui/src/models/prediction.dart';
import 'package:stock_analysis_application_ui/src/widgets/prediction_row_widget.dart';

import 'package:stock_analysis_application_ui/src/providers/stock.service.dart';
import 'package:stock_analysis_application_ui/src/providers/prediction.service.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import 'package:stock_analysis_application_ui/src/common/constants/app_constants.dart';

final tradingWindowIndexValueNotifier = ValueNotifier(0);

class StockScreen extends StatelessWidget {
  final Company company;
  const StockScreen({Key key, this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StockScreenAppBar(
          company: company,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: getStocks(
                    symbol: company.symbol,
                    pageSize: AppConstants.pageSize,
                    pageNumber: 0),
                initialData: List<Stock>(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Stock>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                    case ConnectionState.done:
                      return SizedBox(
                        child: SimpleTimeSeriesChart(
                          stocks: snapshot.data,
                          animate: false,
                        ),
                        height: 450,
                        width: 400,
                      );
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    case ConnectionState.none:
                      return Text("what to do here?");
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              StockScreenPredictions(
                company: company,
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              TradingWindowPicker(),
            ],
          ),
        ));
  }
}

class StockScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Company company;
  @override
  final Size preferredSize = const Size.fromHeight(56.0);
  const StockScreenAppBar({Key key, this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(company.name),
    );
  }
}

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<Stock> stocks;
  final bool animate;

  SimpleTimeSeriesChart({@required this.stocks, this.animate});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: tradingWindowIndexValueNotifier,
      builder: (BuildContext context, tradingWindowIndex, _) {
        return charts.TimeSeriesChart(
          _createChartData(stocks.sublist(
              0, AppConstants.TRADING_WINDOWS[tradingWindowIndex])),
          animate: animate,
          dateTimeFactory: const charts.LocalDateTimeFactory(),
        );
      },
    );
  }

  static List<charts.Series<Stock, DateTime>> _createChartData(
      List<Stock> stocks) {
    return [
      charts.Series<Stock, DateTime>(
          id: 'Stock',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (Stock stock, _) => stock.date,
          measureFn: (Stock stock, _) => stock.close,
          data: stocks)
    ];
  }
}

class StockScreenPredictions extends StatelessWidget {
  final Company company;
  const StockScreenPredictions({Key key, this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPredictions(company.symbol),
      initialData: List<Prediction>(),
      builder:
          (BuildContext context, AsyncSnapshot<List<Prediction>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.done:
            return ValueListenableBuilder(
              valueListenable: tradingWindowIndexValueNotifier,
              builder: (BuildContext context, tradingWindowIndex, _) {
                return StockScreenPredictionsList(
                    predictions: snapshot.data
                        .where((x) =>
                            x.classifier == "GBDT" &&
                            x.tradingWindow ==
                                AppConstants
                                    .TRADING_WINDOWS[tradingWindowIndex])
                        .toList());
              },
            );
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.none:
            return Text("what to do here?");
        }
      },
    );
  }
}

class StockScreenPredictionsList extends StatelessWidget {
  final List<Prediction> predictions;
  const StockScreenPredictionsList({Key key, this.predictions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PredictionRowWidget(predictions[0]),
        Padding(
          padding: EdgeInsets.all(5),
        ),
        PredictionRowWidget(predictions[1]),
        Padding(
          padding: EdgeInsets.all(5),
        ),
        PredictionRowWidget(predictions[2])
      ],
    );
  }
}

class TradingWindowPicker extends StatefulWidget {
  TradingWindowPicker({Key key}) : super(key: key);

  TradingWindowPickerState createState() => TradingWindowPickerState();
}

class TradingWindowPickerState extends State<TradingWindowPicker> {
  int tradingWindowIndex = tradingWindowIndexValueNotifier.value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Trading Window : ${AppConstants.TRADING_WINDOWS[tradingWindowIndex].toString()}",
          style: TextStyle(fontSize: 20),
        ),
        Padding(
          padding: EdgeInsets.all(25),
        ),
        Slider(
          label: AppConstants.TRADING_WINDOWS[tradingWindowIndex].toString(),
          value: tradingWindowIndex.toDouble(),
          onChanged: (value) {
            setState(() {
              tradingWindowIndex = value.toInt();
              tradingWindowIndexValueNotifier.value = tradingWindowIndex;
            });
          },
          min: 0,
          max: AppConstants.TRADING_WINDOWS.length.toDouble() - 1,
          divisions: AppConstants.TRADING_WINDOWS.length - 1,
        ),
      ],
    );
  }
}
