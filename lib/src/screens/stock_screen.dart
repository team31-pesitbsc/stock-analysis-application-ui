import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';

import 'package:stock_analysis_application_ui/src/models/stock.dart';
import 'package:stock_analysis_application_ui/src/models/prediction.dart';
import 'package:stock_analysis_application_ui/src/widgets/prediction_row_widget.dart';

import 'package:stock_analysis_application_ui/src/providers/stock.service.dart';
import 'package:stock_analysis_application_ui/src/providers/prediction.service.dart';
import 'package:rxdart/rxdart.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import 'package:stock_analysis_application_ui/src/common/constants/app_constants.dart';

class StockScreen extends StatelessWidget {
  final Company company;
  const StockScreen({Key key, this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StockScreenAppBar(
        company: company,
      ),
      body: Column(
        children: <Widget>[
          FutureBuilder(
            future:
                getStocks(symbol: company.symbol, pageSize: 30, pageNumber: 0),
            initialData: List<Stock>(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Stock>> snapshot) {
              return SizedBox(
                child: SimpleTimeSeriesChart(
                  stocks: snapshot.data,
                  animate: false,
                ),
                height: 450,
                width: 400,
              );
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
    );
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
    return new charts.TimeSeriesChart(
      _createChartData(stocks),
      animate: animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  static List<charts.Series<Stock, DateTime>> _createChartData(
      List<Stock> stocks) {
    return [
      new charts.Series<Stock, DateTime>(
          id: 'Stock',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (Stock stock, _) => stock.date,
          measureFn: (Stock stock, _) => stock.close,
          data: stocks,
          measureLowerBoundFn: (Stock stock, _) => 40)
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
      builder: (BuildContext context,
          AsyncSnapshot<List<Prediction>> predictionsSnapshot) {
        return StreamBuilder(
          stream: tradingWindowIndexService.stream$,
          initialData: 0,
          builder:
              (BuildContext context, AsyncSnapshot tradingWindowIndexSnapshot) {
            return StockScreenPredictionsList(
                predictions: predictionsSnapshot.data
                    .where((x) =>
                        x.classifier == "GBDT" &&
                        x.tradingWindow ==
                            AppConstants.TRADING_WINDOWS[
                                tradingWindowIndexSnapshot.data])
                    .toList());
          },
        );
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

class TradingWindowIndex {
  BehaviorSubject _tradingWindowIndex = BehaviorSubject.seeded(0);
  Observable get stream$ => _tradingWindowIndex.stream;
  int get current => _tradingWindowIndex.value;
  setTradingWindowIndex(int newTradingWindowIndex) {
    _tradingWindowIndex.add(newTradingWindowIndex);
  }
}

TradingWindowIndex tradingWindowIndexService = TradingWindowIndex();

class TradingWindowPicker extends StatefulWidget {
  TradingWindowPicker({Key key}) : super(key: key);

  TradingWindowPickerState createState() => TradingWindowPickerState();
}

class TradingWindowPickerState extends State<TradingWindowPicker> {
  int tradingWindowIndex = 0;
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
              tradingWindowIndexService
                  .setTradingWindowIndex(tradingWindowIndex);
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
