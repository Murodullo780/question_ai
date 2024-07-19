import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:question_ai_project/mixins/question_mixins.dart';
import 'package:question_ai_project/views/all_feedbacks.dart';
import 'package:question_ai_project/widgets/questions_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with QuestionMixins {
  String difficulty = "";
  String responseText = "";
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PopupMenuButton(
              child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black54),
                  ),
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(difficulty != "" ? difficulty : "Choose difficulty"),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  )),
              itemBuilder: (BuildContext context) {
                return [
                  myPopupButtonItem(context, "Easy", () {
                    difficulty = "Easy";
                    setState(() {});
                  }),
                  myPopupButtonItem(context, "Medium", () {
                    difficulty = "Medium";
                    setState(() {});
                  }),
                  myPopupButtonItem(context, "Hard", () {
                    difficulty = "Hard";
                    setState(() {});
                  }),
                ];
              },
            ),
            TextFormField(
              controller: controller,
              maxLines: null,
              onChanged: (v) {
                // responseText = v;
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: "Enter topic",
                suffixIcon: IconButton(
                  onPressed: () async {
                    if (controller.text != "" && difficulty != "") {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Lottie.asset("assets/json/loading.json"),
                            );
                          });
                      await askQuestion(difficulty, controller.text)
                          .then((value) {
                        responseText = value!;
                        Navigator.pop(context);
                        debugPrint("\n\n\n$responseText\n\n\n");
                        FocusNode().unfocus();
                        isDoneTest = List.generate(5, (index) => false);
                        setState(() {});
                      });
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: controller.text != "" && difficulty != ""
                        ? const Color(0xffF19D38)
                        : Colors.grey,
                  ),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            // InkWell(
            //   onTap: (){
            //     Navigator.push(context, MaterialPageRoute(builder: (context){
            //       return AllFeedbacks();
            //     }));
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //       border: Border.all(color: Colors.black54),
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     margin: const EdgeInsets.only(top: 10, bottom: 10),
            //     width: double.maxFinite,
            //     padding: const EdgeInsets.symmetric(horizontal: 10),
            //     height: 55,
            //     child: const Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text("My feedbacks", style: TextStyle(fontSize: 16),),
            //       ],
            //     ),
            //   ),
            // ),
            const Spacer(),
            responseText == ""
                ? noDataWidget
                : QuestionsWidget(
                    questions: parseQuizQuestions(responseText
                        .replaceAll("```json", "")
                        .replaceAll("```", "")),
                  ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
