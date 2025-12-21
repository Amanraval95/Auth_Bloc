import 'package:bloc/bloc.dart';

import 'nav_event.dart';
import 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavState(0)) {
    on<ChangeTabEvent>((event, emit) {
      emit(NavState(event.index));
    });
  }
}
