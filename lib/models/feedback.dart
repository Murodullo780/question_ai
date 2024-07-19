class MyFeedback{
  int? id;
  String? feedback;
  String? time;

  MyFeedback({this.id, this.feedback, this.time});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['feedback'] = feedback;
    map['time'] = time;
    return map;
  }

  MyFeedback.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feedback = json['feedback'];
    time = json['time'];
  }
}