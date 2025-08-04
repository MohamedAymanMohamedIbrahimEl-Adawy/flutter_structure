import 'package:flutter/material.dart';
import '../../../../../core/component/layout_builder/custom_layout_builder.dart';
import 'desktop_screen.dart';
import 'mobile_screen.dart';
import 'web_screen.dart';

class ProxyDetectionScreen extends StatelessWidget {
  static const String routeName = 'Proxy detection  Screen';
  static const String routePath = '/proxy-detection-screen';
  const ProxyDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomLayoutBuilder(
      mobileView: MobileScreen(),
      webView: WebScreen(),
      desktopView: DesktopScreen(),
    );
  }
}
