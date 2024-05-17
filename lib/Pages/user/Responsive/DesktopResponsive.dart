import 'package:flutter/material.dart';
import 'package:sahha_app/Pages/user/Responsive/DesktopView.dart';
import 'package:sahha_app/Pages/user/Responsive/MobileView.dart';
import 'package:sahha_app/Pages/user/Responsive/TabletView.dart';

class DesktopResponsive extends StatelessWidget {
  const DesktopResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500)
          return MobileView();
        else if (constraints.maxWidth < 1000)
          return TabletView();
        else
          return DesktopView();
      },
    );
  }
}
