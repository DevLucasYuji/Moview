import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class SuccessLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class ErrorLoginState extends LoginState {
  final String message;

  ErrorLoginState(this.message);

  @override
  List<Object> get props => [];
}
