// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> registerUser(
    String email, String password, String displayName) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user != null) {
      User? user = userCredential.user;
      await user?.updateDisplayName(displayName);
      await user?.reload();
    }

    return userCredential;
  } catch (e) {
    print('Hata: $e');
    return null;
  }
}
