import 'dart:async';

import 'package:flutter/material.dart';

import '../data/constants/app_colors.dart';
// import '../../../../../core/global/global_func.dart';

class CustomWidgetsCarousel extends StatefulWidget {
  final List<Widget> children;
  final double? height;
  final Color dotColor;
  final bool showIndicator;
  final Color activeDotColor;
  final Duration autoScrollDuration;
  const CustomWidgetsCarousel({
    super.key,
    required this.children,
    this.height,
    this.showIndicator = true,
    this.autoScrollDuration = const Duration(seconds: 5),
    this.dotColor = Colors.grey,
    this.activeDotColor = AppColors.primaryColor,
  });

  @override
  State<CustomWidgetsCarousel> createState() => _CustomWidgetsCarouselState();
}

class _CustomWidgetsCarouselState extends State<CustomWidgetsCarousel> {
  final PageController _controller = PageController(
    viewportFraction: 0.8,
  );
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(widget.autoScrollDuration, (Timer timer) {
      if (_currentPage < widget.children.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.height ?? 260,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.children.length,
            padEnds: false,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(child: widget.children[index]);
            },
          ),
        ),
        const SizedBox(height: 20),
        // Dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.children.length, (index) {
            return Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? widget.activeDotColor
                    : widget.dotColor,
              ),
            );
          }),
        )
      ],
    );
  }
}

// class CustomCarouselView extends StatelessWidget {
//   final List<Widget> children;
//   final double? itemExtent;
//   final double? height;
//   const CustomCarouselView({
//     super.key,
//     required this.children,
//     this.itemExtent,
//     this.height,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height ?? 300,
//       child: CarouselView(
//         itemExtent: itemExtent ?? MediaQuery.sizeOf(context).width * .77,
//         scrollDirection: Axis.horizontal,
//         itemSnapping: false, // Snap to items when scrolling
//         onTap: (index) {},

//         // Material 3 styling:
//         enableSplash: false,
//         padding: EdgeInsets.zero,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         elevation: 4,
//         backgroundColor: isDarkContext(context)
//             ? AppColors.darkFieldBackgroundColor
//             : Colors.white,
//         children: children,
//       ),
//     );
//   }
// }
