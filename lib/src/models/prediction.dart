class Prediction {
  final String companySymbol;
  final int tradingWindow;
  final int predictionLabel1;
  final double predictionAccuracy1;
  final int predictionLabel3;
  final double predictionAccuracy3;
  final int predictionLabel5;
  final double predictionAccuracy5;

  Prediction({
    this.companySymbol,
    this.tradingWindow,
    this.predictionLabel1,
    this.predictionAccuracy1,
    this.predictionLabel3,
    this.predictionAccuracy3,
    this.predictionLabel5,
    this.predictionAccuracy5,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      companySymbol: json['companySymbol'],
      tradingWindow: json['tradingWindow'],
      predictionLabel1: json['predictionLabel1'],
      predictionAccuracy1: json['predictionAccuracy1'],
      predictionLabel3: json['predictionLabel3'],
      predictionAccuracy3: json['predictionAccuracy3'],
      predictionLabel5: json['predictionLabel5'],
      predictionAccuracy5: json['predictionAccuracy5'],
    );
  }
}
