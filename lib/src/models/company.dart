import 'package:meta/meta.dart';

class Company {
  final String symbol;
  final String name;
  final int bseCode;

  Company({@required this.symbol, @required this.name, @required this.bseCode});

  Company.fromJson(Map<String, dynamic> json)
      : symbol = json['symbol'],
        name = json['name'],
        bseCode = json['bse_code'];
}
