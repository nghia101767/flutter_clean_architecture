import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  final num number;
  final String text;
  final bool found;
  final String type;

  NumberTriviaModel({this.number, this.text, this.found, this.type})
      : super(number: number, text: text);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> jsonMap) {
    final model = NumberTriviaModel(
        number: jsonMap["number"] as num,
        text: jsonMap["text"],
        found: jsonMap["found"],
        type: jsonMap["type"]);
    return model;
  }
  toJson() {
    return {
      "text": text,
      "number": number,
      "found": found,
      "type": type,
    };
  }
}
