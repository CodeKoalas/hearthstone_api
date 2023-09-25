import 'package:flutter/material.dart';

extension ActionInvokeContext on BuildContext {
  void invokeAction(Intent intent) {
    Actions.invoke(this, intent);
  }
}
