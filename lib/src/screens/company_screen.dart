import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stock_analysis_application_ui/src/widgets/company_row_widget.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';

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
        appBar: AppBar(
          title: Text("STOCK ANALYSIS APPLICATION"),
        ),
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

class CompanySearchField extends StatelessWidget {
  final TextEditingController searchController;
  const CompanySearchField({Key key, this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
              labelText: "search for company",
              hintText: "search by name (or) symbol",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        ),
      ),
    );
  }
}

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
