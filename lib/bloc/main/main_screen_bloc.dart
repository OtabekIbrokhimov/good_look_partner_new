import 'package:cutfx_salon/bloc/main/main_screen_event.dart';
import 'package:cutfx_salon/bloc/main/main_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc() : super(InitialMainScreenState()) {
    on<MenuClickEvent>(
      (event, emit) {
        emit(MenuChangeMainScreenState(event.selectedIndex));
      },
    );
  }

  void onMenuClickEvent(int selectedIndex) {
    add(MenuClickEvent(selectedIndex));
  }
}
