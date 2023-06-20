// ignore_for_file: library_private_types_in_public_api, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:movieapp/state/global_variables.dart';
import 'package:provider/provider.dart';

//components
import '../../../components/register_backgorund.dart';

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
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
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
            child: const Text('İleri'),
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
            'Kullanıcı ismi ve Parola girin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Kullanıcı İsmi',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Parola',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              registerUser(_emailController.text.trim(),
                      _passwordController.text, _usernameController.text.trim())
                  .then(
                (value) {
                  GlobalState.user = {
                    'isLogged': true,
                    'username': value?.user?.displayName,
                    'mail': value?.user?.email,
                  };
                  Provider.of<GlobalState>(context, listen: false)
                      .notifyListeners();
                },
              );
            },
            child: const Text('Kayıt ol'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: const Text('Geri'),
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
            'Parolanı gir',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Parola',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              loginUser(_emailController.text.trim(), _passwordController.text)
                  .then(
                (value) {
                  if (value != null) {
                    GlobalState.user = {
                      'isLogged': true,
                      'username': value.user?.displayName,
                      'mail': value.user?.email,
                    };
                    Provider.of<GlobalState>(context, listen: false)
                        .notifyListeners();
                  }
                },
              );
            },
            child: const Text('Giriş Yap'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: const Text('Geri'),
          ),
        ],
      ),
    );
  }
}
