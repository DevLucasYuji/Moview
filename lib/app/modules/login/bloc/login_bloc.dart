import 'dart:async';
import 'package:Moview/app/bloc/bloc_base.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends BlocBase<LoginEvent, LoginState> {
  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEvent) {
      yield LoadingLoginState();
    }
  }
}
