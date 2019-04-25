import 'package:flutter/material.dart';

class CompanyScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(56.0);
  const CompanyScreenAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("STOCK ANALYSIS APPLICATION"),
    );
  }
}
