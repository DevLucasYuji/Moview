import 'package:Moview/app/models/firebase_auth_model.dart';
import 'package:Moview/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

enum FirebaseError {
  email,
  password,
  unknown,
  notFound,
  expired,
  disabled,
  notAllowed,
  manyRequest
}

class FirebaseHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static const userInvalidEmail = "ERROR_INVALID_EMAIL";
  static const userNotFound = "ERROR_USER_NOT_FOUND";
  static const userDisabled = "ERROR_USER_DISABLED";
  static const userManyRequest = "ERROR_TOO_MANY_REQUESTS";
  static const userNotAllowed = "ERROR_OPERATION_NOT_ALLOWED";
  static const userInvalidPassword = "ERROR_WRONG_PASSWORD";

  Future<FirebaseAuthModel> handleSignInEmail(
    String email,
    String password,
  ) async {
    assert(_auth != null, "opora");
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    print('signInEmail succeeded: $user');

    return FirebaseAuthModel(user: user);
  }

  Future<FirebaseUser> get getCurrentUser async {
    return await _auth.currentUser();
  }

  Future<FirebaseUser> handleSignUp(email, password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    return user;
  }

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

  static FirebaseError getFirebaseError(PlatformException error) {
    switch (error.code) {
      case userInvalidEmail:
        return FirebaseError.email;
        break;
      case userInvalidPassword:
        return FirebaseError.password;
        break;
      case userNotFound:
        return FirebaseError.notFound;
        break;
      case userDisabled:
        return FirebaseError.disabled;
        break;
      case userManyRequest:
        return FirebaseError.manyRequest;
        break;
      case userNotAllowed:
        return FirebaseError.notAllowed;
        break;
      default:
        return FirebaseError.unknown;
    }
  }
}
