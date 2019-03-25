class Company {
  final String symbol;
  final String name;

  Company({this.symbol, this.name});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      symbol: json['symbol'],
      name: json['name'],
    );
  }
}
