import 'package:flutter/material.dart';

class AppColor {
  static int blackMode = 0;
  static int standartMode = 1;

  static int _actualMode = standartMode;

  static AppColor _instance;

  AppColor._newInstance();

  factory AppColor() {
    _instance ??= AppColor._newInstance();
    return _instance..fetchColor();
  }

  switchMode() {
    _actualMode = _actualMode == standartMode ? blackMode : standartMode;
    fetchColor();
  }

  Color primary;
  Color primaryVariant;
  Color secondary;
  Color secondaryVariant;
  Color input;
  Color textButton;
  Color background;
  Color backgroundVariant;

  fetchColor() {
    primary = _appColor(dark: Color(0xFF325CD4));
    primaryVariant = _appColor(dark: Color(0xFF5417b0));
    secondary = _appColor(dark: Color(0xFF1c0952));
    secondaryVariant = _appColor(dark: Color(0xFF18204d));
    input = _appColor(dark: Color(0xFF212c69));
    textButton = _appColor(dark: Colors.white);
    background = _appColor(dark: Color(0xFF121212));
    backgroundVariant = _appColor(dark: Color(0xFF101010));
  }

  Color _appColor({Color light, Color dark, Color standart}) {
    return standart ?? _actualMode == standartMode
        ? light ?? dark
        : dark ?? light;
  }
}
