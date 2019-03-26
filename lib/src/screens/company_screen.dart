import 'package:flutter/material.dart';
import 'package:stock_analysis_application_ui/src/widgets/company_row_widget.dart';
import 'package:stock_analysis_application_ui/src/providers/company.service.dart';
import 'package:stock_analysis_application_ui/src/models/company.dart';

class CompanyScreen extends StatefulWidget {
  @override
  State<CompanyScreen> createState() {
    return CompanyScreenState();
  }
}

class CompanyScreenState extends State<CompanyScreen> {
  List<Company> companies = [];
  List<Company> filteredCompanies = [];
  final searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCompanies().then((fetchedCompanies) {
      setState(() {
        companies = fetchedCompanies;
        filteredCompanies = companies;
        searchTextController.addListener(searchTextListener);
      });
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock Analysis App"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(border: Border.all(width: 1.0)),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                textAlign: TextAlign.left,
                controller: searchTextController,
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    CompanyRowWidget(
                      company: filteredCompanies[index],
                      index: index,
                    ),
                itemCount: filteredCompanies.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  searchTextListener() {
    setState(() {
      var searchText = searchTextController.text.toLowerCase();
      filteredCompanies = companies
          .where((company) =>
              company.name.toLowerCase().contains(searchText) ||
              company.symbol.toLowerCase().contains(searchText))
          .toList();
    });
  }
}
