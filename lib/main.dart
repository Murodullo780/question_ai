import 'package:flutter/material.dart';
import 'package:question_ai_project/constants/theme.dart';
import 'package:question_ai_project/routers/routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: MyRoutes.routes,
      title: 'Ai Questions',
      theme: MyTheme.lightTheme,
      initialRoute: MyRoutes.splash,
    );
  }
}
