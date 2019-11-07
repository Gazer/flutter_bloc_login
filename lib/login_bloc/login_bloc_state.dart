import 'package:equatable/equatable.dart';

abstract class LoginBlocState extends Equatable {
  const LoginBlocState();
}

class InitialLoginBlocState extends LoginBlocState {
  @override
  List<Object> get props => [];
}

class LogginInBlocState extends LoginBlocState {
  @override
  List<Object> get props => [];
}

class LoggedInBlocState extends LoginBlocState {
  final String token;

  LoggedInBlocState(this.token);

  @override
  List<Object> get props => [token];
}

class ErrorBlocState extends LoginBlocState {
  final String message;

  ErrorBlocState(this.message);

  @override
  List<Object> get props => [message];
}