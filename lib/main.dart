import 'package:flutter/material.dart';

import 'package:movieapp/ui/onboarding/screen.dart';
import 'package:movieapp/ui/login/screen.dart';
import 'package:movieapp/ui/register/screen.dart';
import 'package:movieapp/ui/main/screen.dart';

void main() {
  runApp(const Start());
}

class Start extends StatelessWidget {
  const Start({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: const ColorScheme(
            background: Colors.black, // bi fikrim yok
            brightness: Brightness.dark, // uygulama teması
            error: Colors.red,
            onBackground: Colors.black, // bi fikrim yok
            onError: Colors.red, // hata kısmı
            onPrimary: Color(0xFFF7D633), // primary
            onSecondary: Colors.white,
            onSurface: Colors.white, // appbar text
            primary: Colors.black,
            secondary: Colors.black,
            surface: Colors.black,
          ),
          scaffoldBackgroundColor: Colors.black,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.black,
            foregroundColor: Color(0xFFF7D633),
          )),
      debugShowCheckedModeBanner: false,
      title: 'MovieApp',
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/mainapp': (context) => const MainApp(),
      },
    );
  }
}
