import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/models/prediction.dart';
import 'package:stock_analysis_application_ui/src/widgets/prediction_dialog_widget.dart';

class PredictionRowWidget extends StatelessWidget {
  final Prediction prediction;

  PredictionRowWidget(this.prediction);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: <Widget>[
          SizedBox(
            child: LinearProgressIndicator(
              value: prediction.probability,
              backgroundColor:
                  prediction.label != -1 ? Colors.lightGreen : Colors.orange,
              valueColor: AlwaysStoppedAnimation(
                  prediction.label != -1 ? Colors.green : Colors.red),
            ),
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: Center(
              child: Text(
                "${prediction.forwardDay} ${prediction.forwardDay == 1 ? 'day' : 'days'} ahead : ${((prediction.probability) * 100).toStringAsFixed(2)}%",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
              ),
            ),
          )
        ],
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
