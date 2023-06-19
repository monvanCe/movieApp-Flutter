import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Giriş Yap'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
