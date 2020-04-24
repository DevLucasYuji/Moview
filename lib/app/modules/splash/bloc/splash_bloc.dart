import 'package:Moview/app/app_module.dart';
import 'package:Moview/app/bloc/bloc_base.dart';
import 'package:Moview/app/helpers/firebase_helper.dart';
import 'package:Moview/app/modules/splash/bloc/splash_event.dart';
import 'package:Moview/app/modules/splash/bloc/splash_state.dart';

class SplashBloc extends BlocBase<SplashEvent, SplashState> {
  @override
  SplashState get initialState => InitialSplashState();

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is InitialEvent) {
      await Future.delayed(Duration(seconds: 3));
      yield SplashAnimationState();
    }

    if (event is FinishSplashEvent) {
      var user =
          await AppModule.to.getDependency<FirebaseHelper>().getCurrentUser;
      yield FinishSplashState(isAuth: user != null, isReverse: event.isReverse);
    }
  }
}
