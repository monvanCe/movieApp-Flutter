// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:movieapp/components/movie_list.dart';
import 'package:movieapp/const/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Hoşgeldin $titleText')),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text(accountName),
              accountEmail: Text(accountEmail),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
              ),
              title: const Text('Settings'),
              onTap: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildMoviesFutureBuilder(apiUrl: "Vizyonda Olanlar"),
            buildMoviesFutureBuilder(apiUrl: "Popüler"),
            buildMoviesFutureBuilder(apiUrl: "En çok Beğenilenler"),
            buildMoviesFutureBuilder(apiUrl: "Yaklaşanlar"),
          ],
        ),
      ),
    );
  }
}