import 'package:flutter/material.dart';
import 'dart:async';

class LoginControllerProvider extends InheritedWidget {
  final StreamController<bool> loginStreamController;

  LoginControllerProvider({
    required this.loginStreamController,
    required Widget child,
  }) : super(child: child);

  static LoginControllerProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LoginControllerProvider>();
  }

  @override
  bool updateShouldNotify(LoginControllerProvider oldWidget) {
    return oldWidget.loginStreamController != loginStreamController;
  }
}
