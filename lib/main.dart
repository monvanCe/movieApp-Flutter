import 'package:flutter/material.dart';
import 'package:movieapp/screens/home_page.dart';
import 'package:movieapp/screens/second_page.dart';
import 'package:movieapp/screens/third_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Set the theme to dark
      title: 'MovieApp',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/second': (context) => SecondPage(),
        '/third': (context) => ThirdPage(),
      },
    );
  }
}
