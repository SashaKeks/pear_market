import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//ThemeMode entity
class ThemeModeEntity extends Equatable {
  const ThemeModeEntity(this._themeMode);

  //ThemeMode
  final ThemeMode _themeMode;
  //ThemeMode getter
  ThemeMode get themeMode => _themeMode;

  //ThemeMode get bool isDark ?
  bool get isDark => _themeMode == ThemeMode.dark;

  @override
  //equtable props for ==
  List<Object?> get props => [_themeMode];
}
