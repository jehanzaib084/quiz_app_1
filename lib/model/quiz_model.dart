class Quiz1 {
  final String id;
  final String title;
  final String description;
  final String difficulty;
  final String questions;
  final String time;

  Quiz1({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.questions,
    required this.time,
  });

  factory Quiz1.fromJson(Map<String, dynamic> json) {
    return Quiz1(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      difficulty: json['difficulty'],
      questions: json['questions'],
      time: json['time'],
    );
  }
}