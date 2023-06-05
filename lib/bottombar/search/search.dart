// ignore_for_file: constant_identifier_names, library_private_types_in_public_api, camel_case_types
import 'package:flutter/material.dart';

//components
import '../../components/main_lists.dart';
import '../../components/search_modal.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.02,
                  vertical: MediaQuery.of(context).size.height * 0.011,
                ),
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showSearchModal(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(231, 231, 231, 1),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        const Text(
                          'Ara',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              MainList(key: UniqueKey(), category: 'Vizyondakiler'),
              const Divider(),
              MainList(key: UniqueKey(), category: 'Popüler'),
              const Divider(),
              MainList(key: UniqueKey(), category: 'Beğenilenler'),
              const Divider(),
              MainList(key: UniqueKey(), category: 'Yaklaşanlar'),
            ],
          ),
        ),
      ),
    );
  }
}
