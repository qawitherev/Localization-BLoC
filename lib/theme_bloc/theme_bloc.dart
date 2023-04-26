import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeLightState()) {
    on<ThemeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ThemeChangeEvent>((event, emit) {
      if (state is ThemeLightState){
        emit(ThemeDarkState());
      }else {
        emit(ThemeLightState());
      }
    });
  }
}
