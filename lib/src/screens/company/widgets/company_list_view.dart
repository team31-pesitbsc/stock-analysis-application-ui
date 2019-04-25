import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/widgets/company_row_widget.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';

class CompanyListView extends StatelessWidget {
  final List<Company> companies;
  const CompanyListView({Key key, this.companies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flexible(
        child: ListView.builder(
          itemCount: companies.length,
          itemBuilder: (BuildContext context, int index) => CompanyRowWidget(
                company: companies[index],
                index: index,
              ),
        ),
      ),
    );
  }
}
