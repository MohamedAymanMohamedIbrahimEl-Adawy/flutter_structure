import 'package:flutter/material.dart';

class ResponsiveHelper {
  final BuildContext context;
  double _screenWidth = 0;
  double _screenHeight = 0;
  double _blockWidth = 0;
  double _blockHeight = 0;
  double _safeAreaHorizontal = 0;
  double _safeAreaVertical = 0;

  ResponsiveHelper(this.context) {
    _init();
  }

  void _init() {
    final mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;

    _safeAreaHorizontal = mediaQuery.padding.left + mediaQuery.padding.right;
    _safeAreaVertical = mediaQuery.padding.top + mediaQuery.padding.bottom;

    _blockWidth = (_screenWidth - _safeAreaHorizontal) / 100;
    _blockHeight = (_screenHeight - _safeAreaVertical) / 100;
  }

  /// Convert width as percentage of total screen width
  double w(double percentage) {
    return _blockWidth * percentage;
  }

  /// Convert height as percentage of total screen height
  double h(double percentage) {
    return _blockHeight * percentage;
  }

  /// Convert text size based on screen width (scale font size)
  double sp(double percentage) {
    return w(percentage);
  }

  /// Get current screen width
  double get screenWidth => _screenWidth;

  /// Get current screen height
  double get screenHeight => _screenHeight;

  /// Determine if the device is in landscape mode
  bool isLandscape() {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Determine if the device is in portrait mode
  bool isPortrait() {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  bool isTablet() {
    // A commonly used threshold for tablets is 600 pixels in width
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  bool isMobile() {
    return MediaQuery.of(context).size.shortestSide < 600;
  }
}
