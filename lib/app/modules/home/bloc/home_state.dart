import 'package:Moview/app/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {}

class InitialHomeState extends HomeState {
  @override
  List<Object> get props => null;
}

class StartLoginState extends HomeState {
  @override
  List<Object> get props => null;
}

class SuccessLoginState extends HomeState {
  final UserModel user;

  SuccessLoginState({this.user});

  @override
  List<Object> get props => [user];
}
