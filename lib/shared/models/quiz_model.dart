import 'dart:convert';

import 'package:DevQuiz/shared/models/question_model.dart';

enum Level { facil, medio, dificil, perito }

extension LevelStringExt on String {
  Level get parse => {
        "facil": Level.facil,
        "medio": Level.medio,
        "dificl": Level.dificil,
        "perito": Level.perito
      }[this]!;
}

extension LevelExt on Level {
  String get parse => {
        Level.facil: "facil",
        Level.medio: "medio",
        Level.dificil: "dificil",
        Level.perito: "perito"
      }[this]!;
}

class QuizModel {
  final String title;
  final String imagem;
  final int questionAnswered;
  final Level level;
  final List<QuestionModel> questions;

  QuizModel({
    required this.title,
    required this.imagem,
    this.questionAnswered = 0,
    required this.level,
    required this.questions,
  }); // : assert( questions.length == 4, );

  Map<String, dynamic> toMap() {
    print(questions);
    return {
      'title': title,
      'imagem': imagem,
      'questionAnswered': questionAnswered,
      'level': level.parse,
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      title: map['title'],
      imagem: map['imagem'],
      questionAnswered: map['questionAnswered'],
      level: map['level'].toString().parse,
      questions: List<QuestionModel>.from(
          map['questions']?.map((x) => QuestionModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source));
}
