import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/prediction.dart';

class PredictionDialogWidget extends StatelessWidget {
  final Prediction prediction;

  PredictionDialogWidget(this.prediction);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        child: Text("Classifier : " + prediction.classifier.toString()),
      ),
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Trading window :  ${prediction.tradingWindow}",
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              "Prediction ${prediction.forwardDay} days from today : ",
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              "Direction : ${prediction.label}",
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              "probability : ${prediction.probability}",
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
