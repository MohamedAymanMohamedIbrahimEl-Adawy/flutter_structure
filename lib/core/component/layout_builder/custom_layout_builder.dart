import 'package:flutter/material.dart';

import '../../data/constants/dimensions.dart';

class CustomLayoutBuilder extends StatelessWidget {
  final Widget mobileView;
  final Widget? tabletView;
  final Widget? webView;
  final Widget? desktopView;
  const CustomLayoutBuilder({
    super.key,
    required this.mobileView,
    this.tabletView,
    this.webView,
    this.desktopView,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < DimensionsConstants.mobileScreenWidth) {
          return mobileView;
        } else if (constraints.maxWidth <
            DimensionsConstants.tabletScreenWidth) {
          return tabletView ?? mobileView;
        } else if (constraints.maxWidth <
            DimensionsConstants.desktopScreenWidth) {
          return desktopView ?? mobileView;
        } else {
          return webView ?? mobileView;
        }
      },
    );
  }
}
