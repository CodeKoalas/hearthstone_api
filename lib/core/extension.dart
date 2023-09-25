import 'package:flutter/material.dart';

extension ContextTextTheme on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}