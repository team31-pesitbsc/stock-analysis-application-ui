class Prediction {
  final int label;
  final double accuracy;

  Prediction({this.label, this.accuracy});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      label: json['label'],
      accuracy: json['accuracy'],
    );
  }
}
