import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/providers/selectedanswers_provider.dart';
import 'package:quiz_app/screens/question_screen.dart';
import 'package:quiz_app/screens/result_screen.dart';
import 'package:quiz_app/screens/categories_screen.dart';
import 'package:quiz_app/screens/quizs_list_screen.dart';
import 'package:quiz_app/model/quiz_model.dart';

class Quiz extends ConsumerStatefulWidget {
  const Quiz({super.key});

  @override
  ConsumerState<Quiz> createState() => _QuizState();
}

class _QuizState extends ConsumerState<Quiz> {
  Quiz1? selectedQuiz;
  String? selectedCategory;

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizsListScreen(
          category: category,
          onStartQuiz: startQuiz,
        ),
      ),
    );
  }

  void startQuiz(Quiz1 quiz) {
    setState(() {
      selectedQuiz = quiz;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionScreen(
          showResult,
          quiz.id,
        ),
      ),
    );
  }

  void showResult() async {
    if (selectedQuiz != null && selectedCategory != null) {
      await Future.delayed(const Duration(seconds: 1)); // Add delay
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            restart,
            selectedQuiz!.id,
            selectedCategory!, // Pass categoryId
          ),
        ),
      );
    }
  }

  void restart() {
    setState(() {
      selectedQuiz = null;
      selectedCategory = null;
    });
    ref.read(selectedAnswersProvider.notifier).restart();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoriesScreen(
        onSelectCategory: selectCategory,
      ),
    );
  }
}
