import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/providers/selectedanswers_provider.dart';
import 'package:quiz_app/screens/question_screen.dart';
import 'package:quiz_app/data/questions_list.dart';
import 'package:quiz_app/screens/result_screen.dart';
import 'package:quiz_app/screens/start_screen.dart';

class Quiz extends ConsumerStatefulWidget {
  const Quiz({super.key});


  @override
  ConsumerState<Quiz> createState() => _QuizState();
}

class _QuizState extends ConsumerState<Quiz> {
  String activescreen = 'start_screen';
  void switchScreen() {
    setState(() {
      activescreen = 'question_screen';
    });
  }

  void showResult() {
    final selectedanswers = ref.watch(selectedAnswersProvider);
    if (selectedanswers.length == questionslist.length) {
      setState(() {
        activescreen = 'result_screen';
      });
    }
  }

  void restart() {
    setState(() {
      activescreen = 'start_screen';
      ref.watch(selectedAnswersProvider.notifier).restart();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget showscreen = StartScreen(switchScreen);
    if (activescreen == 'question_screen') {
      showscreen = QuestionScreen(showResult);
    }
    if (activescreen == 'result_screen') {
      showscreen = ResultScreen(restart);
    }
    if (activescreen == 'start_screen') {
      showscreen = StartScreen(switchScreen);
    }

    return Scaffold(
      body: Container(
        child: showscreen,
      ),
    );
  }
}
