import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  Failure([List properties = const <dynamic>[]])
      : this.properties = properties,
        super();
  @override
  List<Object> get props => properties;
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
