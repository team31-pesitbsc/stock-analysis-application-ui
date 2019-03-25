// TODO - figure out why date time parse is not working and convert stockDate to DateTime type

class Stock {
  final double close;
  final String date;
  final double high;
  final double low;
  final double open;
  final int volume;

  Stock({this.close, this.date, this.high, this.low, this.open, this.volume});

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
        close: json['close'],
        date: json['date'],
        high: json['high'],
        low: json['low'],
        open: json['open'],
        volume: json['volume']);
  }
}
