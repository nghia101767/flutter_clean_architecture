import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NumberTrivia extends Equatable {
  final String text;
  final num number;
  NumberTrivia({@required this.number, @required this.text}) : super();

  @override
  List<Object> get props => [text, number];
}
// {
//  "text": "42 is the number of US gallons in a barrel of oil.",
//  "number": 42,
//  "found": true,
//  "type": "trivia"
// }
