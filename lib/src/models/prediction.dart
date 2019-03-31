class Prediction {
  final int label;
  final double probability;
  final String classifier;
  final int tradingWindow;
  final int forwardDay;

  Prediction(
      {this.label,
      this.probability,
      this.classifier,
      this.tradingWindow,
      this.forwardDay});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
        label: json['label'],
        probability: json['probability'],
        classifier: json['classifier'],
        tradingWindow: json['tradingWindow'],
        forwardDay: json['forwardDay']);
  }
}
