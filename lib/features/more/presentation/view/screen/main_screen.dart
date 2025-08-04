import 'package:flutter/material.dart';
import '../../../../../core/component/layout_builder/custom_layout_builder.dart';
import 'desktop_screen.dart';
import 'mobile_screen.dart';
import 'web_screen.dart';

class MoreScreen extends StatelessWidget {
  static const String routeName = 'More  Screen';
  static const String routePath = '/more-screen';
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomLayoutBuilder(
      mobileView: MobileScreen(),
      webView: WebScreen(),
      desktopView: DesktopScreen(),
    );
  }
}
