import 'package:Moview/app/models/firebase_auth_model.dart';
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

  Future<FirebaseAuthModel> handleSignInEmail(
    String email,
    String password,
  ) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser user = result.user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      print('signInEmail succeeded: $user');

      return FirebaseAuthModel(user: user);
    } on PlatformException catch (exception) {
      return FirebaseAuthModel(exception: exception);
    }
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

  static FirebaseError getFirebaseError(PlatformException error) {
    switch (error.code) {
      case "ERROR_INVALID_EMAIL":
        return FirebaseError.email;
        break;
      case "ERROR_WRONG_PASSWORD":
        return FirebaseError.password;
        break;
      case "ERROR_USER_NOT_FOUND":
        return FirebaseError.notFound;
        break;
      case "ERROR_USER_DISABLED":
        return FirebaseError.disabled;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        return FirebaseError.manyRequest;
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        return FirebaseError.notAllowed;
        break;
      default:
        return FirebaseError.unknown;
    }
  }
}
