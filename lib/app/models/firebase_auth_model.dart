import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class FirebaseAuthModel {
  final FirebaseUser user;
  final PlatformException exception;

  FirebaseAuthModel({this.exception, this.user});
}
