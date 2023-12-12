import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_course/app/app_prefs.dart';
import 'package:flutter_clean_architecture_course/app/di.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final pageController = PageController(initialPage: 0);
  AppPreferences appPreferences = instance<AppPreferences>();
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
