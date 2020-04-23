import 'package:Moview/app/helpers/firebase_helper.dart';
import 'package:Moview/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class FirebaseAuthModel {
  final FirebaseUser user;
  final PlatformException exception;

  FirebaseAuthModel({this.exception, this.user});

  static String getErrorMessage(
    PlatformException exception,
    S translator,
  ) {
    FirebaseError error = FirebaseHelper.getFirebaseError(exception);

    String message;
    switch (error) {
      case FirebaseError.email:
        message = translator.emailWrong;
        break;
      case FirebaseError.password:
        message = translator.passwordWrong;
        break;
      default:
        message = translator.accountNotExist;
        break;
    }

    return message;
  }
}
