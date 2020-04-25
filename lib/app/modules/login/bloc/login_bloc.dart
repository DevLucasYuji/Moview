import 'dart:async';
import 'package:Moview/app/bloc/bloc_base.dart';
import 'package:Moview/app/helpers/firebase_helper.dart';
import 'package:Moview/app/repositories/login_repository.dart';
import 'package:flutter/services.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends BlocBase<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc(this.loginRepository);

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is FetchLoginEvent) {
      yield LoadingLoginState();
      try {
        await loginRepository.handleSignInEmail(
          event.email,
          event.password,
        );
        yield SuccessLoginState();
      } on PlatformException catch (exception) {
        String message = FirebaseHelper.getErrorMessage(
          exception,
          translator,
        );
        yield ErrorLoginState(message);
      }
    }
  }
}
