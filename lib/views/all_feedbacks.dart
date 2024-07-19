import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:question_ai_project/db/db_helper.dart';
import 'package:html/parser.dart';

import '../models/feedback.dart';

class AllFeedbacks extends StatefulWidget {
  const AllFeedbacks({super.key});

  @override
  State<AllFeedbacks> createState() => _AllFeedbacksState();
}

class _AllFeedbacksState extends State<AllFeedbacks> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<MyFeedback> feedbackList = [];

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  getList() {
    databaseHelper.getAllFeedback().then((value) {
      feedbackList = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    getList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All feedbacks"),
      ),
      body: ListView.builder(
        itemCount: feedbackList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Text(parseHtmlString((feedbackList[index].feedback ?? "")
                    .replaceAll("```", "")
                    .replaceAll("```html", ""))),
              ),
            ),
          );
        },
      ),
    );
  }
}
