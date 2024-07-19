import 'package:flutter/material.dart';
import 'package:question_ai_project/question_ai_project.dart';
import 'package:question_ai_project/views/splash_screen.dart';

class MyRoutes{
  static const home = '/home';
  static const splash = '/splash';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const QuestionAiProject(),
    splash: (context) => const SplashScreen(),
  };
}