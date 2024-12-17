import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/data/questions_list.dart';
import 'package:quiz_app/providers/selectedanswers_provider.dart';

final summaryProvider = Provider((ref) {
final selectedAnswers = ref.watch(selectedAnswersProvider);
 List<Map<String, Object>> summery = [];
    for (int i = 0; i < selectedAnswers.length; i++) {
      summery.add({
        'Question_index': i,
        'Question': questionslist[i].text,
        'Correct_Answers': questionslist[i].answers[0],
        'selected_ANswer': selectedAnswers[i],
      });
    }

    return summery;


});