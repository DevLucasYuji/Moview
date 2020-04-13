import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AppEvent extends Equatable {}

class AppColorEvent extends AppEvent {
  @override
  List<Object> get props => [];
}

class AppLanguageEvent extends AppEvent {
  final Locale locale;

  AppLanguageEvent(this.locale);

  @override
  List<Object> get props => [locale];
}
