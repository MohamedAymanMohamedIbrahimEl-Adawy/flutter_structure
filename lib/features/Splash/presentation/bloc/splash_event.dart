import 'package:flutter/material.dart';

abstract class SplashEvent {
  const SplashEvent();
}

class SplashInitEvent extends SplashEvent {
  final  TickerProvider vsync;
  SplashInitEvent(this.vsync,);
}
