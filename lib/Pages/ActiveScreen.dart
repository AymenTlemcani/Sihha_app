import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:sahha_app/Common/MyPersistentNavBar.dart';

class ActiveScreen extends StatefulWidget {
  final StreamController<bool> loginStreamController;
  const ActiveScreen({super.key, required this.loginStreamController});

  @override
  State<ActiveScreen> createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabSreen(
        loginStreamController: widget.loginStreamController);
  }
}
