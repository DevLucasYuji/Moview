import 'package:Moview/app/bloc/bloc_base.dart';
import 'package:Moview/app/modules/home/bloc/home_event.dart';
import 'package:Moview/app/modules/home/bloc/home_state.dart';

class HomeBloc extends BlocBase<HomeEvent, HomeState> {
  @override
  get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(event) async* {}
}
