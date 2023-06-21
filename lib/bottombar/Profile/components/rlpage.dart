// ignore_for_file: library_private_types_in_public_api, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:movieapp/utils/database/db_actions.dart';
import 'package:fluttertoast/fluttertoast.dart';

//components
import '../../../components/parents/register_backgorund.dart';

//utils
import '../../../utils/firebase/check_if_registered.dart';
import '../../../utils/firebase/register.dart';
import '../../../utils/firebase/login.dart';

class RegisterLoginPage extends StatefulWidget {
  const RegisterLoginPage({super.key});

  @override
  _RegisterLoginPage createState() => _RegisterLoginPage();
}

class _RegisterLoginPage extends State<RegisterLoginPage> {
  final PageController _pageController = PageController(initialPage: 0);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isRegistered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              const Positioned.fill(child: RegisterLoginBackground()),
              PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _onboardPage(),
                  _emailPage(),
                  isRegistered ? _loginPage() : _registerPage(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _onboardPage() {
    return Container(
      padding: const EdgeInsets.all(75),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 56,
                height: 56,
              ),
              const SizedBox(width: 8.0),
              const Text(
                'Movie App',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF7D633),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: const Text(
              'Giriş / Kayıt',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailPage() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Email adresinizi girin',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: _emailController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.mail),
              prefixIconColor: const Color(0xFFC9AE29),
              filled: true,
              fillColor: Colors.black,
              labelText: 'Email',
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF7D633),
            ),
            onPressed: () {
              String email = _emailController.text.trim();
              checkIfUserExists(email).then((bool isExist) {
                setState(() {
                  isRegistered = isExist;
                });

                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              });
            },
            child: const Text(
              'İleri',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _registerPage() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Kayıt ol.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: _usernameController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.mail),
              prefixIconColor: const Color(0xFFC9AE29),
              filled: true,
              fillColor: Colors.black,
              labelText: 'Kullanıcı ismi',
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: _passwordController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.mail),
              prefixIconColor: const Color(0xFFC9AE29),
              filled: true,
              fillColor: Colors.black,
              labelText: 'Parola',
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF7D633)),
            onPressed: () {
              if (_usernameController.text.trim().isEmpty) {
                Fluttertoast.showToast(
                  msg: "Lütfen bir kullanıcı ismi giriniz",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              } else {
                registerUser(
                        _emailController.text.trim(),
                        _passwordController.text,
                        _usernameController.text.trim())
                    .then(
                  (value) {
                    if (value != null) {
                      dbSaveUser(context, {
                        'isLogged': true,
                        'username': _usernameController.text.trim(),
                        'mail': _emailController.text.trim(),
                        'UID': value.user?.uid
                      });
                      Fluttertoast.showToast(
                        msg: "Kayıt başarılı",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "en az 6 haneli bir şifre giriniz",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                );
              }
            },
            child: const Text(
              'Kayıt ol',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: const Text(
              'Geri',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginPage() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Giriş Yap.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            controller: _passwordController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.mail),
              prefixIconColor: const Color(0xFFC9AE29),
              filled: true,
              fillColor: Colors.black,
              labelText: 'Parola',
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF7D633)),
            onPressed: () {
              loginUser(_emailController.text.trim(), _passwordController.text)
                  .then(
                (value) {
                  if (value != null) {
                    dbSaveUser(context, {
                      'UID': value.user?.uid,
                      'username': value.user?.displayName,
                      'mail': value.user?.email
                    });
                    Fluttertoast.showToast(
                      msg: "Giriş Başarılı",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg: "Şifrenizi Kontrol Ediniz",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
              );
            },
            child: const Text(
              'Giriş Yap',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: const Text(
              'Geri',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
