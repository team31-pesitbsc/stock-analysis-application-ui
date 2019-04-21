import 'package:meta/meta.dart';

class Prediction {
  final int label;
  final double probability;
  final String classifier;
  final int tradingWindow;
  final int forwardDay;

  Prediction(
      {@required this.label,
      @required this.probability,
      @required this.classifier,
      @required this.tradingWindow,
      @required this.forwardDay});

  Prediction.fromJson(Map<String, dynamic> json)
      : label = json['label'],
        probability = json['probability'],
        classifier = json['classifier'],
        tradingWindow = json['tradingWindow'],
        forwardDay = json['forwardDay'];
}
