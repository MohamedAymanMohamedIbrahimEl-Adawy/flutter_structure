import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/custom_toast/p_toast.dart';
import 'package:cleanarchitecture/core/data/constants/global_obj.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';

showPToast({required String message, MessageType? type, int seconds = 4}) {
  OverlayEntry? overlayEntry;

  overlayEntry = OverlayEntry(
    builder:
        (BuildContext context) => Positioned(
          top: 0,
          left: 10,
          right: 10,
          child: _ToastAnimatedWidget(
            child: Material(
              child: Container(
                decoration: BoxDecoration(
                  color: getColorByType(type ?? MessageType.success),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.fromLTRB(30, 20, 60, 20),
                child: Text(
                  message,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
  );
  Overlay.of(navigatorKey.currentState!.context).insert(overlayEntry);

  Future.delayed(Duration(seconds: seconds), (() {
    overlayEntry?.remove();
  }));
}

class _ToastAnimatedWidget extends StatefulWidget {
  const _ToastAnimatedWidget({required this.child});

  final Widget child;

  @override
  _ToastWidgetState createState() => _ToastWidgetState(child);
}

class _ToastWidgetState extends State<_ToastAnimatedWidget>
    with SingleTickerProviderStateMixin {
  final Widget childContent;

  late final AnimationController _forwardController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<Offset> _forwardOffsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, 1),
  ).animate(_forwardController);

  @override
  initState() {
    _forwardController.forward();
    _forwardController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 2), () {
          _forwardController.reverse();
          // }
        });
      }
    });
    super.initState();
  }

  _ToastWidgetState(this.childContent);

  @override
  void dispose() {
    if (_forwardController.isCompleted) {
      _forwardController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _forwardOffsetAnimation,
      child: childContent,
    );
  }
}
