// ignore_for_file: library_private_types_in_public_api, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:flutter/material.dart';

//components
import 'package:movieapp/components/search_modal_list.dart';

//services
import '../services/network.dart';

void showSearchModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (BuildContext context) {
      return const SearchModal();
    },
  );
}

class SearchModal extends StatefulWidget {
  const SearchModal({super.key});

  @override
  _SearchModalState createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  List<dynamic> searchedMovies = [];

  Future<void> _searchMovies(String query) async {
    final movies = await searchFunction(query);
    setState(() {
      searchedMovies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (query) {
                        _searchMovies(query);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                      cursorColor: const Color(0xFFF7D633),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchedMovies.length,
                itemBuilder: (BuildContext context, int index) {
                  final movie = searchedMovies[index];
                  return searchModalList(context, movie);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
