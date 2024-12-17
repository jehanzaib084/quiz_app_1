class QuestionsClass {
  QuestionsClass(this.text, this.answers);
  final String text;
  final List<String> answers;

  List<String> shuffleAnswers() {
    final shuffled = List.of(answers);
    shuffled.shuffle();
    return shuffled;
  }
}
