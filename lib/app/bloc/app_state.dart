import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AppState {}

class InitialAppState extends AppState {}

class AppLanguageState extends AppState {}

class AppColorState extends AppState {}
