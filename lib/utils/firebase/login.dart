// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> loginUser(String email, String password) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  } catch (e) {
    print('Hata: $e');
    return null;
  }
}
