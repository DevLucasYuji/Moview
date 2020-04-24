import 'dart:async';
import 'package:Moview/app/bloc/bloc_base.dart';
import 'package:Moview/app/models/firebase_auth_model.dart';
import 'package:Moview/app/modules/login/login_module.dart';
import 'package:Moview/app/repositories/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends BlocBase<LoginEvent, LoginState> {
  LoginRepository loginRepository = LoginModule.to.getDependency();

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is FetchLoginEvent) {
      yield LoadingLoginState();
      var user = await loginRepository.handleSignInEmail(
        event.email,
        event.password,
      );

      if (user.exception != null) {
        yield ErrorLoginState(
          FirebaseAuthModel.getErrorMessage(
            user.exception,
            translator,
          ),
        );
      }

      if (user.user != null) {
        yield SuccessLoginState();
      }
    }
  }
}
