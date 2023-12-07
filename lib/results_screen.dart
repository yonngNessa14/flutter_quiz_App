import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/questions_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.choosenAnswers, this.restart});

  final void Function()? restart;

  final List<String> choosenAnswers;

  List<Map<String, Object>> _getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < choosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': choosenAnswers[i]
      });
    }

    return summary;
  }

  num _getCorrectAnswersNo() {
    final data = _getSummaryData().where(
        (element) => element['user_answer'] == element['correct_answer']);

    return data.length;
  }

  @override
  Widget build(BuildContext context) {
    final num answered = _getCorrectAnswersNo();
    final num questionsNum = questions.length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "You answered $answered out of $questionsNum questions correctly",
              style: GoogleFonts.lato(
                fontSize: 20,
                color: const Color.fromARGB(255, 201, 153, 251),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            QuestionsSummary(_getSummaryData()),
            const SizedBox(height: 30),
            TextButton.icon(
              onPressed: restart,
              icon: const Icon(Icons.restart_alt_rounded),
              label: const Text('Restart Quiz'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white70,
              ),
            )
          ],
        ),
      ),
    );
  }
}
