import 'package:Moview/app/helpers/firebase_helper.dart';
import 'package:Moview/app/models/firebase_auth_model.dart';
import '../app_module.dart';

class LoginRepository {
  final FirebaseHelper firebaseHelper = AppModule.to.getDependency();

  Future<FirebaseAuthModel> handleSignInEmail(String email, String password) =>
      firebaseHelper.handleSignInEmail(email, password);
}
