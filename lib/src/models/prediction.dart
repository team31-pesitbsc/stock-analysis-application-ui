class Prediction {
  final int label;
  final double accuracy;
  final String classifier;
  final int tradingWindow;
  final int forwardDay;

  Prediction(
      {this.label,
      this.accuracy,
      this.classifier,
      this.tradingWindow,
      this.forwardDay});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
        label: json['label'],
        accuracy: json['accuracy'],
        classifier: json['classifier'],
        tradingWindow: json['tradingWindow'],
        forwardDay: json['forwardDay']);
  }
}
