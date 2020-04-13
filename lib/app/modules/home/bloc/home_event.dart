import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {}

class LoginEvent extends HomeEvent {
  final String email;
  final String password;

  LoginEvent({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
