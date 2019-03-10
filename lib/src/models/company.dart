class Company {
  final String companySymbol;
  final String companyName;

  Company({this.companySymbol, this.companyName});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companySymbol: json['companySymbol'],
      companyName: json['companySymbol'],
    );
  }
}