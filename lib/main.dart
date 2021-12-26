import 'package:flutter/material.dart';
import 'package:sqlite_coba/pages/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1461900230 EAS-PTM ',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
