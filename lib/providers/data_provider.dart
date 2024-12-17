import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/json_service.dart';

final categoriesProvider = FutureProvider((ref) => JsonService.getCategories());
final quizzesProvider = FutureProvider((ref) => JsonService.getQuizzes());
final questionsProvider = FutureProvider((ref) => JsonService.getQuestions());

final categoryQuizzesProvider = FutureProvider.family((ref, String categoryId) async {
  final quizzes = await ref.watch(quizzesProvider.future);
  return quizzes.where((quiz) => quiz['categoryId'] == categoryId).toList();
});

final quizQuestionsProvider = FutureProvider.family((ref, String quizId) async {
  final questions = await ref.watch(questionsProvider.future);
  return questions.where((q) => q['quizId'] == quizId).toList();
});