import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeControlState extends Equatable {}

class InitialHomeControlState extends HomeControlState {
  @override
  List<Object> get props => null;
}
