import 'package:flutter/services.dart';
import 'dart:convert';

class JsonService {
  static Future<Map<String, dynamic>> loadJson(String path) async {
    final String response = await rootBundle.loadString('assets/data/$path');
    return json.decode(response);
  }

  static Future<List<dynamic>> getCategories() async {
    final data = await loadJson('categories.json');
    return data['categories'];
  }

  static Future<List<dynamic>> getQuizzes() async {
    final data = await loadJson('quizzes.json');
    return data['quizzes'];
  }

  static Future<List<dynamic>> getQuestions() async {
    final data = await loadJson('questions.json');
    return data['questions'];
  }

  static Future<List<dynamic>> getQuizQuestions(String quizId) async {
    final questions = await getQuestions();
    return questions.where((q) => q['quizId'] == quizId).toList();
  }
}