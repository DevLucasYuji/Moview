import 'package:flutter/material.dart';

class AppColor {
  static int blackMode = 0;
  static int standartMode = 1;

  static int _actualMode = standartMode;

  static AppColor _instance;

  AppColor._newInstance();

  factory AppColor() {
    _instance ??= AppColor._newInstance();
    return _instance..onChanged();
  }

  switchMode() {
    _actualMode = _actualMode == standartMode ? blackMode : standartMode;
    onChanged();
  }

  static const Color primaryColor = Color(0xFF325CD4);
  static const Color secundaryColor = Color(0xFF090B15);

  Color primary;
  Color secondary;

  onChanged() {
    if (_actualMode == standartMode) {
      primary = primaryColor;
      secondary = secundaryColor;
    } else {
      primary = primaryColor;
      secondary = secundaryColor;
    }
  }
}
