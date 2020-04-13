import 'dart:async';
import 'package:Moview/app/bloc/bloc_base.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BlocBase<HomeEvent, HomeState> {
  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {}
}
