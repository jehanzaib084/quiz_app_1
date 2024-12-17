import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadSampleData() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Categories Data
  final List<Map<String, dynamic>> categories = [
    {
      'id': 'math',
      'title': 'Mathematics',
      'icon': 'calculate',
    },
    {
      'id': 'science',
      'title': 'Science',
      'icon': 'science',
    },
    {
      'id': 'history',
      'title': 'History',
      'icon': 'history_edu',
    }
  ];

  // Quizzes Data
  final List<Map<String, dynamic>> quizzes = [
    // Mathematics Quizzes
    {
      'id': 'math_basic',
      'categoryId': 'math',
      'title': 'Basic Mathematics',
      'description': 'Test your basic math skills',
      'difficulty': 'Easy',
      'questionCount': 10,
      'timeInMinutes': 15,
    },
    {
      'id': 'math_intermediate',
      'categoryId': 'math',
      'title': 'Intermediate Mathematics',
      'description': 'Challenge yourself with algebra and geometry',
      'difficulty': 'Medium',
      'questionCount': 15,
      'timeInMinutes': 20,
    },
    {
      'id': 'math_advanced',
      'categoryId': 'math',
      'title': 'Advanced Mathematics',
      'description': 'Complex problems and calculations',
      'difficulty': 'Hard',
      'questionCount': 20,
      'timeInMinutes': 30,
    },

    // Science Quizzes
    {
      'id': 'science_basic',
      'categoryId': 'science',
      'title': 'Basic Science',
      'description': 'Learn fundamental science concepts',
      'difficulty': 'Easy',
      'questionCount': 10,
      'timeInMinutes': 15,
    },
    {
      'id': 'science_intermediate',
      'categoryId': 'science',
      'title': 'Intermediate Science',
      'description': 'Explore complex scientific theories',
      'difficulty': 'Medium',
      'questionCount': 15,
      'timeInMinutes': 20,
    },
    {
      'id': 'science_advanced',
      'categoryId': 'science',
      'title': 'Advanced Science',
      'description': 'Deep dive into scientific concepts',
      'difficulty': 'Hard',
      'questionCount': 20,
      'timeInMinutes': 30,
    },

    // History Quizzes
    {
      'id': 'history_basic',
      'categoryId': 'history',
      'title': 'Basic History',
      'description': 'Test your knowledge of basic historical events',
      'difficulty': 'Easy',
      'questionCount': 10,
      'timeInMinutes': 15,
    },
    {
      'id': 'history_intermediate',
      'categoryId': 'history',
      'title': 'Intermediate History',
      'description': 'Explore world history in detail',
      'difficulty': 'Medium',
      'questionCount': 15,
      'timeInMinutes': 20,
    },
    {
      'id': 'history_advanced',
      'categoryId': 'history',
      'title': 'Advanced History',
      'description': 'Complex historical analysis',
      'difficulty': 'Hard',
      'questionCount': 20,
      'timeInMinutes': 30,
    },
  ];

  final List<Map<String, dynamic>> questions = [
    // Math Basic Questions
    {
      'id': 'math_basic_q1',
      'quizId': 'math_basic',
      'question': 'What is 2 + 2?',
      'options': ['3', '4', '5', '6'],
      'correctAnswer': '4',
    },
    {
      'id': 'math_basic_q2',
      'quizId': 'math_basic',
      'question': 'What is 5 × 5?',
      'options': ['15', '20', '25', '30'],
      'correctAnswer': '25',
    },

    // Math Intermediate Questions
    {
      'id': 'math_int_q1',
      'quizId': 'math_intermediate',
      'question': 'Solve for x: 2x + 5 = 15',
      'options': ['5', '10', '7.5', '8'],
      'correctAnswer': '5',
    },
    {
      'id': 'math_int_q2',
      'quizId': 'math_intermediate',
      'question': 'What is the area of a circle with radius 5?',
      'options': ['25π', '10π', '15π', '20π'],
      'correctAnswer': '25π',
    },

    // Science Basic Questions
    {
      'id': 'science_basic_q1',
      'quizId': 'science_basic',
      'question': 'What is the chemical symbol for water?',
      'options': ['H2O', 'CO2', 'O2', 'N2'],
      'correctAnswer': 'H2O',
    },
    {
      'id': 'science_basic_q2',
      'quizId': 'science_basic',
      'question': 'What is the largest planet in our solar system?',
      'options': ['Mars', 'Jupiter', 'Saturn', 'Venus'],
      'correctAnswer': 'Jupiter',
    },

    // Science Intermediate Questions
    {
      'id': 'science_int_q1',
      'quizId': 'science_intermediate',
      'question': 'What is the atomic number of Carbon?',
      'options': ['5', '6', '7', '8'],
      'correctAnswer': '6',
    },
    {
      'id': 'science_int_q2',
      'quizId': 'science_intermediate',
      'question': 'Which organelle is known as the powerhouse of the cell?',
      'options': ['Nucleus', 'Mitochondria', 'Golgi body', 'Endoplasmic reticulum'],
      'correctAnswer': 'Mitochondria',
    },

    // History Basic Questions
    {
      'id': 'history_basic_q1',
      'quizId': 'history_basic',
      'question': 'Who was the first President of the United States?',
      'options': ['John Adams', 'Thomas Jefferson', 'George Washington', 'Benjamin Franklin'],
      'correctAnswer': 'George Washington',
    },
    {
      'id': 'history_basic_q2',
      'quizId': 'history_basic',
      'question': 'In which year did World War II end?',
      'options': ['1943', '1944', '1945', '1946'],
      'correctAnswer': '1945',
    },

    // History Intermediate Questions
    {
      'id': 'history_int_q1',
      'quizId': 'history_intermediate',
      'question': 'Which empire was ruled by Julius Caesar?',
      'options': ['Greek', 'Roman', 'Persian', 'Ottoman'],
      'correctAnswer': 'Roman',
    },
    {
      'id': 'history_int_q2',
      'quizId': 'history_intermediate',
      'question': 'The Renaissance period began in which country?',
      'options': ['France', 'England', 'Italy', 'Spain'],
      'correctAnswer': 'Italy',
    },
  ];

  // Upload to Firestore
  try {
    // Upload categories
    for (var category in categories) {
      await firestore
          .collection('categories')
          .doc(category['id'])
          .set(category);
    }

    // Upload quizzes
    for (var quiz in quizzes) {
      await firestore
          .collection('quizzes')
          .doc(quiz['id'])
          .set(quiz);
    }

    // Upload questions
    for (var question in questions) {
      await firestore
          .collection('questions')
          .doc(question['id'])
          .set(question);
    }

    print('Sample data uploaded successfully!');
  } catch (e) {
    print('Error uploading data: $e');
  }
}