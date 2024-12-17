import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quiz_app/model/quiz_model.dart';

class QuizService {
  Future<List<Quiz1>> getQuizzesByCategory(String category) async {
    try {
      final String response = await rootBundle
          .loadString('assets/quizzes/${category.toLowerCase()}.json');
      final data = await json.decode(response);
      
      return (data['quizzes'] as List)
          .map((quiz) => Quiz1.fromJson(quiz))
          .toList();
    } catch (e) {
      throw Exception('Failed to load quizzes for $category');
    }
  }
}