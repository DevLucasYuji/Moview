import 'dart:async';
import 'package:Moview/app/bloc/bloc_base.dart';
import 'home_control_event.dart';
import 'home_control_state.dart';

class HomeControlBloc extends BlocBase<HomeControlEvent, HomeControlState> {
  @override
  HomeControlState get initialState => InitialHomeControlState();

  @override
  Stream<HomeControlState> mapEventToState(HomeControlEvent event) async* {}
}
