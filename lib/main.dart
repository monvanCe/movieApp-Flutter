import 'package:flutter/material.dart';

import 'package:movieapp/ui/homepage/home_page.dart';
import 'package:movieapp/ui/searchpage/search_page.dart';
import 'package:movieapp/ui/favoritespage/favorites_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'MovieApp',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/second': (context) => const SearchPage(),
        '/third': (context) => const FavoritesPage(),
      },
    );
  }
}
