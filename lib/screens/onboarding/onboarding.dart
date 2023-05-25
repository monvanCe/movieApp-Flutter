// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Widget> _pages = [
    const OnboardingPage(
      title: "Welcome to MyApp",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      imageUrl: "assets/images/onboarding_1.png",
    ),
    const OnboardingPage(
      title: "Get started",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      imageUrl: "assets/images/onboarding_2.png",
    ),
    const OnboardingPage(
      title: "Let's go!",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      imageUrl: "assets/images/onboarding_3.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index];
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => buildDot(index: index),
            ),
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () {
              if (_currentPage == _pages.length - 1) {
                // navigate to home screen or any other screen you want to show after onboarding
                Navigator.pushReplacementNamed(context, '/login');
              } else {
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              _currentPage == _pages.length - 1 ? "Get started" : "Next",
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }

  Widget buildDot({required int index}) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      width: 12.0,
      height: 12.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://free4kwallpapers.com/uploads/wallpaper/bladerunner--movie-scene-wallpaper-1024x768-wallpaper.jpg',
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          const SizedBox(height: 48.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
