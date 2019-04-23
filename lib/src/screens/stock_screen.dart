import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';

import 'package:stock_analysis_application_ui/src/models/stock.dart';
import 'package:stock_analysis_application_ui/src/models/prediction.dart';

import 'package:stock_analysis_application_ui/src/widgets/stock_row_widget.dart';
import 'package:stock_analysis_application_ui/src/widgets/keep_alive_future_builder.dart';
import 'package:stock_analysis_application_ui/src/widgets/prediction_row_widget.dart';

import 'package:stock_analysis_application_ui/src/providers/stock.service.dart';
import 'package:stock_analysis_application_ui/src/providers/prediction.service.dart';
import 'package:rxdart/rxdart.dart';

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
          Padding(
            padding: EdgeInsets.all(50),
          ),
          StockScreenPredictions(
            company: company,
          ),
          Padding(
            padding: EdgeInsets.all(30),
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
                        x.classifier == "RF" &&
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
    return Slider(
      label: AppConstants.TRADING_WINDOWS[tradingWindowIndex].toString(),
      value: tradingWindowIndex.toDouble(),
      onChanged: (value) {
        setState(() {
          tradingWindowIndex = value.toInt();
          tradingWindowIndexService.setTradingWindowIndex(tradingWindowIndex);
        });
      },
      min: 0,
      max: AppConstants.TRADING_WINDOWS.length.toDouble() - 1,
      divisions: AppConstants.TRADING_WINDOWS.length - 1,
    );
  }
}

// class StockScreen extends StatefulWidget {
//   final Company company;

//   StockScreen({Key key, this.company}) : super(key: key);
//   @override
//   _StockScreenState createState() => _StockScreenState();
// }

// class _StockScreenState extends State<StockScreen> {
//   List<Prediction> predictions;
//   String classifier = AppConstants.CLASSIFIERS[0];
//   int tradingWindow = AppConstants.TRADING_WINDOWS[0];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Stock Page"),
//       ),
//       body: Column(
//         children: <Widget>[
//           Column(
//             children: <Widget>[
//               Text(
//                 widget.company.name,
//                 style: TextStyle(fontSize: 25.0),
//               ),
//               Text(
//                 widget.company.symbol,
//                 style: TextStyle(fontSize: 15.0),
//               )
//             ],
//           ),
//           Container(
//               margin: EdgeInsets.symmetric(vertical: 5.0),
//               height: MediaQuery.of(context).size.height * 0.53,
//               child: ListView.builder(
//                   reverse: true,
//                   itemBuilder: (context, pageNumber) {
//                     return KeepAliveFutureBuilder(
//                       future: getStocks(
//                           symbol: widget.company.symbol,
//                           pageSize: AppConstants.pageSize,
//                           pageNumber: pageNumber),
//                       builder: (context, snapshot) {
//                         switch (snapshot.connectionState) {
//                           case ConnectionState.none:
//                           case ConnectionState.waiting:
//                             return SizedBox(
//                                 height: MediaQuery.of(context).size.height * 2,
//                                 child: Align(
//                                     alignment: Alignment.topCenter,
//                                     child: CircularProgressIndicator()));
//                           case ConnectionState.active:
//                             break;
//                           case ConnectionState.done:
//                             if (snapshot.hasError) {
//                               return Text('Error: ${snapshot.error}');
//                             } else {
//                               return this._buildPage(snapshot.data);
//                             }
//                         }
//                       },
//                     );
//                   })),
//           Row(
//             children: <Widget>[
//               DropdownButton<String>(
//                 hint: Text("CLASSIFIER"),
//                 onChanged: (String newValue) {
//                   setState(() {
//                     classifier = newValue;
//                   });
//                 },
//                 items: AppConstants.CLASSIFIERS
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               DropdownButton<int>(
//                 hint: Text("TRADING_WINDOWS"),
//                 onChanged: (int newValue) {
//                   setState(() {
//                     tradingWindow = newValue;
//                   });
//                 },
//                 items: AppConstants.TRADING_WINDOWS
//                     .map<DropdownMenuItem<int>>((int value) {
//                   return DropdownMenuItem<int>(
//                     value: value,
//                     child: Text(value.toString()),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//           Container(
//               margin: EdgeInsets.symmetric(vertical: 10.0),
//               height: MediaQuery.of(context).size.height * 0.15,
//               child: FutureBuilder(
//                 future: getPredictions(widget.company.symbol),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<List<Prediction>> snapshot) {
//                   switch (snapshot.connectionState) {
//                     case ConnectionState.none:
//                       return Text('Press button to start.');
//                     case ConnectionState.active:
//                     case ConnectionState.waiting:
//                       return Text('Awaiting result...');
//                     case ConnectionState.done:
//                       if (snapshot.hasError)
//                         return Text('Error: ${snapshot.error}');
//
//                   }
//                 },
//               )),
//         ],
//       ),
//     );
//   }

//   Widget _buildPage(List<Stock> page) {
//     return ListView(
//         reverse: true,
//         shrinkWrap: true,
//         primary: false,
//         children: page.map((Stock stock) {
//           return StockRowWidget(stock);
//         }).toList());
//   }
// }
