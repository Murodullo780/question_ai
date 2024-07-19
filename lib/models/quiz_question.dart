class QuizQuestion {
  int? id;
  String? question;
  List<String>? options;
  String? correctAnswer;
  String? userAnswer;

  QuizQuestion(
      {this.id,
        this.question,
        this.options,
        this.correctAnswer,
        this.userAnswer});

  QuizQuestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    options = List<String>.from(json['options']);
    correctAnswer = json['correct_answer'];
    userAnswer = json['user_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['question'] = this.question;
    data['options'] = this.options;
    data['correct_answer'] = this.correctAnswer;
    data['user_answer'] = this.userAnswer;
    return data;
  }

  @override
  String toString() {
    return 'QuizQuestion{id: $id, question: $question, options: $options, correctAnswer: $correctAnswer, userAnswer: $userAnswer}';
  }
}