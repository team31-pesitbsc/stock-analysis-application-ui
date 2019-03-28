import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stock_analysis_application_ui/src/models/prediction.dart';
import 'package:stock_analysis_application_ui/src/widgets/prediction_dialog_widget.dart';

class PredictionWidget extends StatelessWidget {
  final Prediction prediction;

  PredictionWidget(this.prediction);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
        child: Container(
          child: Row(
            children: <Widget>[
              CircularPercentIndicator(
                animation: true,
                radius: 60,
                lineWidth: 5,
                percent: prediction.accuracy,
                header: Column(
                  children: <Widget>[
                    Text("Classifier : ${prediction.classifier}"),
                    Text(
                        "Trading Window : ${prediction.tradingWindow.toString()}"),
                    Text("${prediction.forwardDay.toString()} day ahead"),
                  ],
                ),
                center: Icon(prediction.label == 1
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
                backgroundColor: Colors.grey,
                progressColor:
                    prediction.label == 1 ? Colors.green : Colors.red,
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return PredictionDialogWidget(prediction);
            });
      },
    );
  }
}
