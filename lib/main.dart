import 'package:flutter/material.dart';
import 'package:quotes_flutter/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes',
      home: SplashScreen(),
    );
  }
}
