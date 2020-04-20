import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {}

class FetchLoginEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}
