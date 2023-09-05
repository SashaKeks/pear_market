import 'package:flutter/material.dart';
import 'package:pear_market/features/main_app/domain/entities/theme_mode_entity.dart';

//ThemeMode model
class ThemeModeModel extends ThemeModeEntity {
  const ThemeModeModel(super._themeMode);

  //parce data to bool for add to shared pref
  bool dataToPref() => super.themeMode == ThemeMode.dark;

  // parce data from bool to model
  factory ThemeModeModel.fromPref(bool themeMode) {
    return ThemeModeModel(themeMode ? ThemeMode.dark : ThemeMode.light);
  }

  // parce entity to model
  factory ThemeModeModel.fromEntity(ThemeModeEntity entity) {
    return ThemeModeModel(entity.themeMode);
  }
}
