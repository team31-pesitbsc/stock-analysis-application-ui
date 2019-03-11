// TODO - figure out why date time parse is not working and convert stockDate to DateTime type

class Stock {
  final String companySymbol;
  final double stockClose;
  final String stockDate;
  final double stockHigh;
  final double stockLow;
  final double stockOpen;
  final int stockVolume;

  Stock(
      {this.companySymbol,
      this.stockClose,
      this.stockDate,
      this.stockHigh,
      this.stockLow,
      this.stockOpen,
      this.stockVolume});

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
        companySymbol: json['companySymbol'],
        stockClose: json['stockClose'],
        stockDate: json['stockDate'],
        stockHigh: json['stockHigh'],
        stockLow: json['stockLow'],
        stockOpen: json['stockOpen'],
        stockVolume: json['stockVolume']);
  }
}
