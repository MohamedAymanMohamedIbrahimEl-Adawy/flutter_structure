import 'package:flutter/material.dart';

class PFloatingActionButton extends StatefulWidget {
  final Widget child;

  const PFloatingActionButton({super.key, required this.child});

  @override
  PFloatingActionButtonState createState() => PFloatingActionButtonState();
}

class PFloatingActionButtonState extends State<PFloatingActionButton> {
  // Initial position of the FAB
  double posX = 100;
  double posY = 100;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The draggable FAB
        Positioned(
          left: posX,
          top: posY,
          child: GestureDetector(
            onPanUpdate: (details) {
              // Update position based on drag movement
              setState(() {
                posX += details.delta.dx;
                posY += details.delta.dy;
              });
            },
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
