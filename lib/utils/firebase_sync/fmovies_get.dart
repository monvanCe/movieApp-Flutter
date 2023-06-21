import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> getFMoviesByUID(String uid) async {
  List<Map<String, dynamic>> movies = [];

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('movies')
      .where('UID', isEqualTo: uid)
      .get();

  for (var doc in querySnapshot.docs) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    if (data != null) {
      movies.add(data);
    }
  }

  return movies;
}
