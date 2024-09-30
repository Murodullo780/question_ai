// import 'package:flutter/material.dart';
// import 'package:question_ai_project/mixins/feedback_mixins.dart';
// import 'package:question_ai_project/models/feedback_json.dart';
//
// class FeedbackWidget extends StatelessWidget with FeedbackMixins {
//   final String feedbackJson;
//
//   const FeedbackWidget({
//     super.key,
//     required this.feedbackJson,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     giveFeedback(feedbackJson);
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.red,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       padding: const EdgeInsets.all(10),
//       child: FutureBuilder(
//         future: giveFeedback(feedbackJson),
//         builder: (context, snap) {
//           return Text(
//             snap.data?.feedback ?? "",
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           );
//         }
//       ),
//     );
//   }
// }
