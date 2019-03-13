import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';
import 'package:stock_analysis_application_ui/src/models/stock.dart';

import 'package:stock_analysis_application_ui/src/widgets/stock_row.dart';
import 'package:stock_analysis_application_ui/src/providers/stock.service.dart';
import 'package:stock_analysis_application_ui/src/common/constants/app_constants.dart';

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
      body:
          Container(child: ListView.builder(itemBuilder: (context, pageNumber) {
        return KeepAliveFutureBuilder(
          future: getStocks(
              companySymbol: widget.company.companySymbol,
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
        shrinkWrap: true,
        primary: false,
        children: page.map((Stock stock) {
          return StockRow(stock);
        }).toList());
  }
}

class KeepAliveFutureBuilder extends StatefulWidget {
  final Future future;
  final AsyncWidgetBuilder builder;

  KeepAliveFutureBuilder({this.future, this.builder});

  @override
  _KeepAliveFutureBuilderState createState() => _KeepAliveFutureBuilderState();
}

class _KeepAliveFutureBuilderState extends State<KeepAliveFutureBuilder>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: widget.builder,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
