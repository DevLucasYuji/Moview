import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SplashEvent extends Equatable {}

class InitialEvent extends SplashEvent {
  @override
  List<Object> get props => [];
}

class FinishEvent extends SplashEvent {
  @override
  List<Object> get props => [];
}
