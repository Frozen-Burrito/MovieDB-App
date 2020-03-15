import 'package:flutter/material.dart';

// Pages
import 'package:movie_app_2/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      debugShowCheckedModeBanner: false,

      initialRoute: '/',
      routes: {
        '/': ( BuildContext context ) => HomePage(),
      }
    );
  }
}