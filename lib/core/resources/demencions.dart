import 'dart:ui';

class AppDemensions {
  //Device
  static final double deviceWidth = window.physicalSize.width;

  //size
  static final appSize3 = (deviceWidth / 430).floor();
  static final appSize5 = deviceWidth / 258;
  static final appSize10 = deviceWidth / 129;
  static final appSize20 = deviceWidth / 64.5;
  static final appSize25 = deviceWidth / 51.6;
  static final appSize50 = deviceWidth / 25.8;
  static final appSize300 = deviceWidth / 4.3;
  static final appSize150 = deviceWidth / 8.6;
  static final appSize100 = deviceWidth / 12.9;
  static final appSize200 = deviceWidth / 6.45;
}
