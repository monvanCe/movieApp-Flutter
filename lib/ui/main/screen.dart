import 'package:flutter/material.dart';

import 'package:movieapp/ui/home/screen.dart';
import 'package:movieapp/ui/search/screen.dart';
import 'package:movieapp/ui/favorites/screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MyAppState();
}

class _MyAppState extends State<MainApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const FavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme(
            background: Colors.black, // bi fikrim yok
            brightness: Brightness.dark, // uygulama teması
            error: Colors.red,
            onBackground: Colors.black, // bi fikrim yok
            onError: Colors.red, // hata kısmı
            onPrimary: Color(0xFFF7D633), // primary
            onSecondary: Colors.white,
            onSurface: Colors.white, // appbar text
            primary: Colors.black,
            secondary: Colors.black,
            surface: Colors.black,
          ),
          scaffoldBackgroundColor: Colors.black,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.black,
            foregroundColor: Color(0xFFF7D633),
          )),
      title: 'MovieApp',
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          unselectedFontSize: 12,
          selectedFontSize: 12,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.movie,
                size: 32,
              ),
              label: 'Ana Sayfa',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 32,
              ),
              label: 'Ara',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 32,
              ),
              label: 'Favoriler',
            ),
          ],
        ),
      ),
    );
  }
}
