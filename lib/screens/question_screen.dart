import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/providers/selectedanswers_provider.dart';
import 'package:quiz_app/data/questions_list.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends ConsumerStatefulWidget {
  const QuestionScreen(this.showResult, {super.key});
  final void Function() showResult;
  @override
  ConsumerState<QuestionScreen> createState() => _QuestionState();
}

class _QuestionState extends ConsumerState<QuestionScreen> {
  var currentquestionindex = 0;

  void changeIndex(String answers) {
    ref.read(selectedAnswersProvider.notifier).choosedAnswers(answers);
    if (currentquestionindex < questionslist.length - 1) {
      setState(() {
        currentquestionindex++;
      });
    } else {
      widget.showResult();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentquestion = questionslist[currentquestionindex];
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
                value: (currentquestionindex + 1) / questionslist.length,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              SizedBox(height: 40),
              Text(
                'Question ${currentquestionindex + 1}/${questionslist.length}',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.white.withOpacity(0.9),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    currentquestion.text,
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: ListView(
                  children: currentquestion
                      .shuffleAnswers()
                      .map(
                        (answer) => AnswerButton(
                          answer,
                          () => changeIndex(answer),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
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
