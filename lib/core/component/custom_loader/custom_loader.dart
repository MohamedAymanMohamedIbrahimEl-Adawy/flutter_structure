import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';

class CustomLoader extends StatelessWidget {
  final LoadingShape loadingShape;
  final double size;
  final Color? color;

  const CustomLoader({
    super.key,
    this.loadingShape = LoadingShape.wave,
    this.color,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    switch (loadingShape) {
      case LoadingShape.wave:
        return SpinKitWave(
          color: AppColors.primaryColor,
          size: size,
          itemCount: 8,
        );
      case LoadingShape.waveSpinner:
        return SpinKitWaveSpinner(
          color: color ?? AppColors.primaryColor,
          size: size,
        );
      case LoadingShape.fadingCircle:
        return SpinKitFadingCircle(
          color: color ?? AppColors.primaryColor,
          size: size,
        );
      case LoadingShape.cubeGrid:
        return SpinKitCubeGrid(
          color: color ?? AppColors.primaryColor,
          size: size,
        );
      case LoadingShape.foldingCube:
        return SpinKitFoldingCube(
          color: color ?? AppColors.primaryColor,
          size: size,
        );
      case LoadingShape.pouringHourGlassRefined:
        return SpinKitPouringHourGlassRefined(
          color: AppColors.primaryColor,
          size: size,
        );
      default:
        return SpinKitWave(
          color: color ?? AppColors.primaryColor,
          size: size,
          itemCount: 8,
        );
    }
  }
}

class LoadAnimation extends StatefulWidget {
  final Widget child;
  final bool? enable;

  const LoadAnimation({required this.child, super.key, this.enable = false});

  @override
  LoadAnimationState createState() => LoadAnimationState();
}

class LoadAnimationState extends State<LoadAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;

  @override
  void initState() {
    if (widget.enable ?? false) {
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      )..repeat();
    }
    super.initState();
  }

  @override
  void dispose() {
    if (controller != null) {
      controller!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.enable ?? false)
        ? Stack(
          children: <Widget>[
            widget.child,
            Positioned.fill(
              child: ClipRect(
                child: AnimatedBuilder(
                  animation: controller!,
                  builder: (context, child) {
                    return FractionallySizedBox(
                      widthFactor: .2,
                      alignment:
                          AlignmentGeometryTween(
                                begin: const Alignment(-1.0 - .2 * 3, .0),
                                end: const Alignment(1.0 + .2 * 3, .0),
                              )
                              .chain(CurveTween(curve: Curves.easeOut))
                              .evaluate(controller!)!,
                      child: child,
                    );
                  },
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(0, 255, 255, 255),
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
        : widget.child;
  }
}
