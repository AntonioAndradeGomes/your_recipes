import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get _theme => Theme.of(this);
  ColorScheme get colorScheme => _theme.colorScheme;
  TextTheme get textTheme => _theme.textTheme;
}
