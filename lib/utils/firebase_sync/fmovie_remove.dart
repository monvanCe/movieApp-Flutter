import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> fMovieRemove(int movieId) async {
  final collectionRef = FirebaseFirestore.instance.collection('movies');

  final querySnapshot =
      await collectionRef.where('movieId', isEqualTo: movieId).get();

  for (var doc in querySnapshot.docs) {
    doc.reference.delete();
  }
}
