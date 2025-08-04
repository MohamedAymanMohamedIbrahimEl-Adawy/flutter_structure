import 'dart:async';

import 'package:flutter/material.dart';

class PCarousel<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T) itemBuilder;
  final double height;
  final double? width;
  final double? viewportFraction;
  final Duration animationDuration;
  final Duration autoScrollDuration;
  final Color dotColor;
  final bool showIndicator;
  final Color activeDotColor;

  const PCarousel({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.height = 200,
    this.width,
    this.showIndicator = true,
    this.viewportFraction=1.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.autoScrollDuration = const Duration(seconds:5),
    this.dotColor = Colors.grey,
    this.activeDotColor = Colors.blue,
  });

  @override
  CustomCarouselState<T> createState() => CustomCarouselState<T>();
}

class CustomCarouselState<T> extends State<PCarousel<T>> {
  late final PageController _pageController;
  late Timer _autoScrollTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction:widget.viewportFraction!);

    // Start the auto-scroll timer
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(widget.autoScrollDuration, (timer) {
      if (_currentIndex < widget.items.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: widget.animationDuration,
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(width:widget.width,
          constraints: widget.showIndicator?const BoxConstraints(
            maxHeight:316, minHeight:280
          ):null,
          height:widget.showIndicator?null:widget.height,
          child: Align(alignment:Alignment.centerRight,
            child: PageView.builder(
              padEnds:false,pageSnapping:false,
              controller: _pageController,
              itemCount: widget.items.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return widget.itemBuilder(widget.items[index]);
              },
            ),
          ),
        ),
        if(widget.showIndicator)const SizedBox(height: 10),
        if(widget.showIndicator)Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.items.length, (index) {
            return InkWell(onTap:() {
              _currentIndex=index;
              _pageController.animateToPage(
                index,
                duration: widget.animationDuration,
                curve: Curves.easeInOut,
              );
              setState(() {});
            },child: AnimatedContainer(
                duration: widget.animationDuration,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentIndex == index ? 12 : 10,
                height: 12,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? widget.activeDotColor
                      : widget.dotColor,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}





