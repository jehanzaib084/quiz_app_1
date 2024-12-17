import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/screens/question_screen.dart';
import 'package:quiz_app/screens/quizs_list_screen.dart';
import '../providers/selectedanswers_provider.dart';
import '../services/json_service.dart';

class ResultScreen extends ConsumerWidget {
  final void Function() restart;
  final String quizId;
  final String categoryId;

  const ResultScreen(this.restart, this.quizId, this.categoryId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAnswers = ref.watch(selectedAnswersProvider);

    return FutureBuilder<List<dynamic>>(
      future: JsonService.getQuizQuestions(quizId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final questions = snapshot.data!;
        int correctAnswers = 0;

        for (var i = 0; i < questions.length; i++) {
          if (i < selectedAnswers.length &&
              selectedAnswers[i] == questions[i]['correctAnswer']) {
            correctAnswers++;
          }
        }

        final score = (correctAnswers / questions.length) * 100;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.shade800, Colors.purple.shade800],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Quiz Results',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${score.toStringAsFixed(0)}%',
                          style: GoogleFonts.poppins(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: score >= 70 ? Colors.green : Colors.red,
                          ),
                        ),
                        Text(
                          '$correctAnswers out of ${questions.length} correct',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: ListView.builder(
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        final question = questions[index];
                        final userAnswer = index < selectedAnswers.length
                            ? selectedAnswers[index]
                            : null;
                        final correctAnswer = question['correctAnswer'];
                        final isCorrect = userAnswer == correctAnswer;

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          color: isCorrect
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                          child: ListTile(
                            title: Text(
                              question['question'],
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your answer: $userAnswer',
                                  style: GoogleFonts.poppins(
                                    color:
                                        isCorrect ? Colors.green : Colors.red,
                                  ),
                                ),
                                Text(
                                  'Correct answer: $correctAnswer',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          ref.read(selectedAnswersProvider.notifier).restart();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuestionScreen(
                                restart,
                                quizId,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          backgroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.refresh, color: Colors.purple),
                        label: Text(
                          'Try Again',
                          style: GoogleFonts.poppins(
                            color: Colors.purple,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          ref.read(selectedAnswersProvider.notifier).restart();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizsListScreen(
                                category: categoryId,
                                onStartQuiz: (quiz) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QuestionScreen(
                                        restart,
                                        quiz.id,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          backgroundColor: Colors.purple,
                        ),
                        icon: const Icon(Icons.done, color: Colors.white),
                        label: Text(
                          'Done',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
