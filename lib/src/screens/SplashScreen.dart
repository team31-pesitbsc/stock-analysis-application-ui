import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Center(
            child: Stack(
              children: <Widget>[
                Image.asset('assets/icon/icon.png'),
                SizedBox(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 5),
                    child: CircularProgressIndicator(strokeWidth: 5.0),
                  ),
                  height: 200.0,
                  width: 200.0,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
