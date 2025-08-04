import 'package:flutter/material.dart';
import '../../../../../core/component/layout_builder/custom_layout_builder.dart';
import 'desktop_screen.dart';
import 'mobile_screen.dart';
import 'web_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'Home  Screen';
  static const String routePath = '/home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomLayoutBuilder(
      mobileView: MobileScreen(),
      webView: WebScreen(),
      desktopView: DesktopScreen(),
    );
  }
}
