import 'package:flutter/material.dart';

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
