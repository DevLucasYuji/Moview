import 'package:Moview/app/helpers/firebase_helper.dart';
import 'package:Moview/app/models/firebase_auth_model.dart';

class LoginRepository {
  final FirebaseHelper _firebaseHelper = FirebaseHelper();

  Future<FirebaseAuthModel> handleSignInEmail(String email, String password) =>
      _firebaseHelper.handleSignInEmail(email, password);
}
