import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SplashState extends Equatable {}

class InitialSplashState extends SplashState {
  @override
  List<Object> get props => null;
}

class SplashAnimationState extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashFinishState extends SplashState {
  @override
  List<Object> get props => [];
}

class FinishSplashState extends SplashState {
  final bool isAuth;

  FinishSplashState({this.isAuth});

  @override
  List<Object> get props => [isAuth];
}
