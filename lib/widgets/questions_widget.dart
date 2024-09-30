import 'package:flutter/material.dart';
import 'package:question_ai_project/models/quiz_question.dart';
import 'package:question_ai_project/views/feedback_screen.dart';

import '../mixins/question_mixins.dart';

class QuestionsWidget extends StatefulWidget {
  final List<QuizQuestion> questions;
  final Function(int)? onDone;

  const QuestionsWidget({
    super.key,
    required this.questions,
    this.onDone,
  });

  @override
  State<QuestionsWidget> createState() => _QuestionsWidgetState();
}

class _QuestionsWidgetState extends State<QuestionsWidget> with QuestionMixins {
  int _selectedValue = 0;

  @override
  void initState() {
    isDoneTest = List.generate(widget.questions.length, (index) => false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        widget.questions.length,
        (index) {
          return isDoneTest[index] == true
              ? Container()
              : Container(
                  height: MediaQuery.of(context).size.height - 235,
                  color: const Color(0xffF8F5FE),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.questions[index].question ?? "",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      // Text(widget.questions[index].correctAnswer ?? ""),
                      Column(
                        children: List.generate(
                          4,
                          (index4) {
                            return RadioListTile(
                              title: Text(
                                  widget.questions[index].options?[index4] ??
                                      ""),
                              value: index4 + 1,
                              groupValue: _selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value!;
                                  widget.questions[index].userAnswer =
                                      widget.questions[index].options?[index4];
                                  setState(() {});
                                  debugPrint(
                                      widget.questions[index].userAnswer);
                                });
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 60,
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: widget.questions[index].userAnswer == null
                              ? Colors.grey
                              : const Color(0xffF19D38),
                        ),
                        child: InkWell(
                          onTap: () async {
                            {
                              if (widget.questions[index].userAnswer != null) {
                                isDoneTest[index] = true;
                                _selectedValue = 0;
                                debugPrint("$isDoneTest");
                              }
                              if (isDoneTest
                                  .every((element) => element == true)) {
                                debugPrint("All done");
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FeedbackScreen(
                                      questions: widget.questions,
                                    ),
                                  ),
                                );
                                (widget.onDone??(int index){})(index).call();
                              }
                            }

                            setState(() {});
                          },
                          child: const Center(child: Text("Next")),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
