// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:movieapp/components/movie_list.dart';

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
        backgroundColor: Colors.black,
        title: const Center(child: Text('Welcome monvanCe')),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Ömer Faruk Koca"),
              accountEmail: Text("omerfkoca@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.red,
              ),
              title: const Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.green,
              ),
              title: const Text('Settings'),
              onTap: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {},
            ),
            const Text('Ana Sayfa'),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            const Text('Ara')
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      body: buildMoviesFutureBuilder(),
    );
  }
}
