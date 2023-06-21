// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> fMovieAdd(String uid, int movieId, bool isWatched) async {
  final CollectionReference moviesCollection =
      FirebaseFirestore.instance.collection('movies');

  final QuerySnapshot snapshot = await moviesCollection
      .where('UID', isEqualTo: uid)
      .where('movieId', isEqualTo: movieId)
      .get();

  if (snapshot.docs.isEmpty) {
    await moviesCollection.add({
      'UID': uid,
      'movieId': movieId,
      'isWatched': isWatched,
    });
    print('Film başarıyla eklendi.');
  } else {
    final existingDoc = snapshot.docs.first;
    final existingData = existingDoc.data();
    print('Bu film zaten koleksiyonda mevcut: $existingData');

    final updatedData = {
      'UID': uid,
      'movieId': movieId,
      'isWatched': isWatched,
    };

    await existingDoc.reference.update(updatedData);
    print('Film verileri güncellendi.');
  }
}
