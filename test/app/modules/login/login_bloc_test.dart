import 'package:Moview/app/app_module.dart';
import 'package:Moview/app/helpers/firebase_helper.dart';
import 'package:Moview/app/models/firebase_auth_model.dart';
import 'package:Moview/app/modules/login/bloc/login_bloc.dart';
import 'package:Moview/app/modules/login/bloc/login_event.dart';
import 'package:Moview/app/modules/login/bloc/login_state.dart';
import 'package:Moview/app/modules/login/login_module.dart';
import 'package:Moview/app/repositories/login_repository.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  initModule(AppModule());
  initModule(LoginModule());

  MockLoginRepository mockLoginRepository;
  LoginBloc loginBloc;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    loginBloc = LoginBloc(mockLoginRepository);
  });

  group('LoginBloc -> ', () {
    final firebaseUser = FirebaseAuthModel();
    final event = FetchLoginEvent();
    test('Bloc is instace of LoginBloc', () {
      expect(loginBloc, isInstanceOf<LoginBloc>());
    });

    blocTest(
      "Fetch login with successfully",
      build: () async {
        when(mockLoginRepository.handleSignInEmail(any, any)).thenAnswer(
          (_) async => firebaseUser,
        );
        return loginBloc;
      },
      act: (bloc) => bloc.add(event),
      expect: [
        LoadingLoginState(),
        SuccessLoginState(),
      ],
    );
    test('Fetch login with error', () {
      when(mockLoginRepository.handleSignInEmail(any, any)).thenThrow(
        PlatformException(code: FirebaseHelper.userInvalidEmail),
      );

      loginBloc.add(event);
      expectLater(
          loginBloc,
          emitsInOrder([
            InitialLoginState(),
            LoadingLoginState(),
            ErrorLoginState(loginBloc.translator.emailWrong),
          ]));
    });
  });
}
