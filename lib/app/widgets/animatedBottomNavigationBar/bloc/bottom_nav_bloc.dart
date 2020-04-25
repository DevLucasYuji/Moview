import 'package:bloc_pattern/bloc_pattern.dart';

class BottomNavBloc extends BlocBase {
  int index = 1;

  void setIndex(int n) {
    index = n;
    notifyListeners();
  }
}
