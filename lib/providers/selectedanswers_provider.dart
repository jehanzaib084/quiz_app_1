import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedAnswersNotifier extends StateNotifier<List<String>> {
 SelectedAnswersNotifier():super([]);

void choosedAnswers(String answers)
{
state = [...state,answers];
}

void restart()
{
  state=[];
}

}

final selectedAnswersProvider = StateNotifierProvider<SelectedAnswersNotifier,List<String>>((ref) => 
SelectedAnswersNotifier());


