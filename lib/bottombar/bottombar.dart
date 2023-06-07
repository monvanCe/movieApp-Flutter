import 'package:flutter/material.dart';

//pages
import './Films/films.dart';
import './search/search.dart';
import './Profile/profile.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MyAppState();
}

class _MyAppState extends State<MainApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Films(),
    const SearchPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieApp',
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black38,
          selectedItemColor: Colors.black87,
          currentIndex: _selectedIndex,
          unselectedFontSize: 10,
          selectedFontSize: 10,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.movie_outlined,
                size: 28,
              ),
              label: 'Filmler',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 28,
              ),
              label: 'Keşfet',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 28,
              ),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
