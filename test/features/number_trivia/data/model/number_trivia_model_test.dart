import 'dart:convert';

import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(
      number: 42,
      text:
          "42 is the angle in degrees for which a rainbow appears or the critical angle.",
      found: true,
      type: "trivia");

  test("should test number model", () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });
  group("fromJson", () {
    test("number integer", () async {
      final Map<String, dynamic> jsonMap = jsonDecode(fixture("trivia.json"));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });
  });
}
// {
//  "text": "42 is the number of US gallons in a barrel of oil.",
//  "number": 42,
//  "found": true,
//  "type": "trivia"
// }
