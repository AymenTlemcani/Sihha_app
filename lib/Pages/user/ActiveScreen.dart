import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sahha_app/Pages/user/Responsive/DesktopResponsive.dart';
import 'package:sahha_app/Pages/user/MyPersistentNavBar.dart';

class ActiveScreen extends StatefulWidget {
  const ActiveScreen({
    super.key,
  });

  @override
  State<ActiveScreen> createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> {
  @override
  Widget build(BuildContext context) {
    return (Platform.isAndroid || Platform.isIOS)
        ? PersistentTabSreen()
        : DesktopResponsive();
  }
}
