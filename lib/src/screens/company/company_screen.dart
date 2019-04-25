import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';
import 'package:stock_analysis_application_ui/src/screens/company/widgets/company_list_view.dart';
import 'package:stock_analysis_application_ui/src/screens/company/widgets/company_search_field.dart';
import 'package:stock_analysis_application_ui/src/screens/company/widgets/company_screen_app_bar.dart';

class CompanyScreen extends StatefulWidget {
  final List<Company> companies;
  CompanyScreen({Key key, @required this.companies}) : super(key: key);
  @override
  CompanyScreenState createState() => CompanyScreenState();
}

class CompanyScreenState extends State<CompanyScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() => {setState(() {})});
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CompanyScreenAppBar(),
        body: Container(
          child: Column(
            children: <Widget>[
              CompanySearchField(
                searchController: searchController,
              ),
              CompanyListView(
                companies: widget.companies
                    .where((company) =>
                        company.name
                            .toLowerCase()
                            .contains(searchController.text) ||
                        company.symbol
                            .toLowerCase()
                            .contains(searchController.text))
                    .toList(),
              ),
            ],
          ),
        ));
  }
}
