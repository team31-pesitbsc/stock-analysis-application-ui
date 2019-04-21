import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class Stock {
  final double close;
  final DateTime date;
  final double high;
  final double low;
  final double open;
  final int volume;

  Stock(
      {@required this.close,
      @required this.date,
      @required this.high,
      @required this.low,
      @required this.open,
      @required this.volume});

  factory Stock.fromJson(Map<String, dynamic> json) {
    DateFormat dateFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss ZZZ");
    return Stock(
        close: json['close'],
        date: dateFormat.parse(json['date']),
        high: json['high'],
        low: json['low'],
        open: json['open'],
        volume: json['volume']);
  }
}
