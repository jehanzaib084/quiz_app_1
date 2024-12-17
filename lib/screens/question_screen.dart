import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/providers/selectedanswers_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/services/json_service.dart';

class QuestionScreen extends ConsumerStatefulWidget {
  const QuestionScreen(this.showResult, this.quizId, {super.key});
  final void Function() showResult;
  final String quizId;

  @override
  ConsumerState<QuestionScreen> createState() => _QuestionState();
}

class _QuestionState extends ConsumerState<QuestionScreen> {
  var currentquestionindex = 0;
  late Future<List<dynamic>> _questionsFuture;
  List<dynamic> questions = [];

  // Add changeIndex method
  void changeIndex(String answer) {
    // Store selected answer
    ref.read(selectedAnswersProvider.notifier).choosedAnswers(answer);
    
    // Move to next question or show results
    if (currentquestionindex < questions.length - 1) {
      setState(() {
        currentquestionindex++;
      });
    } else {
      widget.showResult();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() async {
    _questionsFuture = JsonService.getQuizQuestions(widget.quizId);
    questions = await _questionsFuture;
    if (questions.isEmpty) {
      setState(() {
        currentquestionindex = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _questionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LinearProgressIndicator(
                    value: questions.isEmpty ? 0 : (currentquestionindex + 1) / questions.length,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    questions.isEmpty ? 'Quiz Information' : 'Question ${currentquestionindex + 1}/${questions.length}',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.white.withOpacity(0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        questions.isEmpty 
                            ? 'No questions available for this quiz.'
                            : questions[currentquestionindex]['question'],
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (questions.isNotEmpty)
                    Expanded(
                      child: ListView(
                        children: [
                          ...(questions[currentquestionindex]['options'] as List)
                              .map(
                                (answer) => AnswerButton(
                                  answer,
                                  () => changeIndex(answer),
                                ),
                              )
                              ,
                        ],
                      ),
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

class AnswerButton extends StatelessWidget {
  const AnswerButton(this.answertext, this.onTap, {super.key});

  final String answertext;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue.shade800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 4,
        ),
        onPressed: onTap,
        child: Text(
          answertext,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
