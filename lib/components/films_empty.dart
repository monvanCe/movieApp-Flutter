import 'package:flutter/material.dart';
import 'package:movieapp/utils/db_actions.dart';

//components
import '../components/search_modal.dart';

Widget filmsEmpty(BuildContext context) {
  return SafeArea(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'İzleme listen boş!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(
            'assets/empty-movie.png',
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 20),
          const Text(
            'İzlemek istediğin filmleri ekle.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () {
                dbGet();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF7D633),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20), // Set the desired radius value
                ),
              ),
              child: const Text(
                'Film Ara',
                style: TextStyle(
                  color: Colors.black, // Set the desired text color
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
