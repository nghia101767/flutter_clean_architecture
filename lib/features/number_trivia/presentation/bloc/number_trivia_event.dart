part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetNumberTriviaEvent extends NumberTriviaEvent {
  final String numberString;

  GetNumberTriviaEvent(this.numberString);
  int get number => int.parse(numberString);
}

class GetRandomNumberTriviaEvent extends NumberTriviaEvent {}
