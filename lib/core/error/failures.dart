import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];

  get message => null;
}

// General failures
class ServerFailure extends Failure {
  final String? message;

  ServerFailure({this.message});
}

class CacheFailure extends Failure {
  final String? message;

  CacheFailure({this.message});
}
