// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> checkIfUserExists(String email) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;

    List<String> methods = await auth.fetchSignInMethodsForEmail(email);

    if (methods.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Hata: $e');
    return false;
  }
}
