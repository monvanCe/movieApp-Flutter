import 'package:flutter/material.dart';

class Films extends StatefulWidget {
  const Films({Key? key}) : super(key: key);

  @override
  State<Films> createState() => _HomePageState();
}

class _HomePageState extends State<Films> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
