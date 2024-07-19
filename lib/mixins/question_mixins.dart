import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:question_ai_project/models/quiz_question.dart';

const apiKey = "AIzaSyAKN7sSYCEIutf10K8VW8R66CBKdta09Lk";

mixin QuestionMixins {

  List<bool> isDoneTest = [];

  PopupMenuItem myPopupButtonItem(
      BuildContext context, String text, VoidCallback onTap) {
    return PopupMenuItem(
      enabled: true,
      value: 1,
      onTap: onTap,
      child: SizedBox(
        width: double.maxFinite,
        child: Text(text),
      ),
    );
  }

  Widget noDataWidget = const Column(
    children: [
      Text(
        "No Quiz Yet",
        style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
            color: Color(0xffF19D38)),
      ),
      Text(
        "Enter Topic To generete One",
        style: TextStyle(fontSize: 16),
      ),
    ],
  );

  Future<String?> askQuestion(String level, String topic) async {
    String question = ''
        'Create 5 questions at an easy $level on $topic with 4 options in JSON format indicating the correct answer. which is one of the ransom options.'
        'Here is sample response format:'
        'json[{'
        ' "question": "Simple question",'
        '"options": ["Option1", "Option2", "Option3", "Option4"],'
        '"correct_answer": "Option2"'
        ' }]'
        '';

    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );

    final content = [Content.text(question)];
    final response = await model.generateContent(content);
    return response.text;
  }

  String textForAskQuestion(int order, QuizQuestion question) {
    return ''
        'Question ${order + 1} is: ${question.question}'
        'My answer: ${question.userAnswer}'
        'Correct answer: ${question.correctAnswer}'
        '';
  }

  Future<String?> askAnalyse(List<QuizQuestion> questions) async {
    String question = '''
    Please analyze and send in html the following 5 quiz answers and provide suggestions for improvement:
    ${questions.map((e) => textForAskQuestion(questions.indexOf(e), e)).join('\n')}
    ''';
    print(question);

    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );

    final content = [Content.text(question)];
    final response = await model.generateContent(content);
    return response.text;
  }

  List<QuizQuestion> parseQuizQuestions(String jsonString) {
    final List<dynamic> parsedList = json.decode(jsonString);
    return parsedList.map((json) => QuizQuestion.fromJson(json)).toList();
  }
}
