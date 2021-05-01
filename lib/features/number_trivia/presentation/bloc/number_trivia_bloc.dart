import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/util/input_converter.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required InputConverter inputConverter,
  })  : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        this.getConcreteNumberTrivia = concrete,
        this.getRandomNumberTrivia = random,
        this.inputConverter = inputConverter,
        super(Empty());

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetNumberTriviaEvent) {
      final inputEither =
          inputConverter.stringToUnsignedInt(event.numberString);
      yield Loading();
      yield* inputEither.fold((failure) async* {
        yield Error(message: _mapFailureMessage(failure));
      }, (integer) async* {
        final failureOrTrivia =
            await getConcreteNumberTrivia(Params(number: integer));
        yield* _eitherLoadedOrError(failureOrTrivia);
      });
    }
    if (event is GetRandomNumberTriviaEvent) {
      yield Loading();
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      yield* _eitherLoadedOrError(failureOrTrivia);
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrError(
      Either<Failure, NumberTrivia> failureOrTrivia) async* {
    yield failureOrTrivia.fold(
        (failure) => Error(message: _mapFailureMessage(failure)),
        (trivia) => Loaded(trivia: trivia));
  }
}

String _mapFailureMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return "SERVER FAILED MESSAGE";
    case CacheFailure:
      return "CACHE FAILED MESSAGE";
    case InvalidInputFailure:
      return "INPUT INVALID FAILED MESSAGE";
    default:
      return "Unimplement error";
  }
}
