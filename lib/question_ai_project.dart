import 'package:flutter/material.dart';
import 'package:question_ai_project/views/quiz_screen.dart';

class QuestionAiProject extends StatelessWidget {
  const QuestionAiProject({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: QuizScreen(),
    );
  }
}
