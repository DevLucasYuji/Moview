import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AppState {}

class InitialAppState extends AppState {}

class AppLanguageState extends AppState {}

class AppColorState extends AppState {}
