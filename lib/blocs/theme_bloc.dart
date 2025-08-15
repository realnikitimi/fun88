import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.light)) {
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  void _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) {
    emit(
      ThemeState(themeMode: event.isDark ? ThemeMode.dark : ThemeMode.light),
    );
  }
}

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {
  final bool isDark;
  const ToggleThemeEvent(this.isDark);

  @override
  List<Object> get props => [isDark];
}

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  const ThemeState({required this.themeMode});

  @override
  List<Object> get props => [themeMode];
}
