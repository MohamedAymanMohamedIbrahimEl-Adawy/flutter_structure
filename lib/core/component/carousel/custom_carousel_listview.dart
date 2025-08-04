import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';

class PListViewCarousel<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T) itemBuilder;
  final double height;
  final double? width;
  final Duration autoScrollDuration;
  final Color dotColor;
  final bool showIndicator;
  final Color activeDotColor;

  const PListViewCarousel({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.height = 200,
    this.width,
    this.showIndicator = true,
    this.autoScrollDuration = const Duration(seconds: 5),
    this.dotColor = Colors.grey,
    this.activeDotColor = AppColors.primaryColor,
  });

  @override
  PListViewCarouselState<T> createState() => PListViewCarouselState<T>();
}

class PListViewCarouselState<T> extends State<PListViewCarousel<T>> {
  late final ScrollController _scrollController;
  late Timer _autoScrollTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateCurrentIndex);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _scrollController.removeListener(_updateCurrentIndex);
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(widget.autoScrollDuration, (timer) {
      if (_currentIndex < widget.items.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _scrollToIndex(_currentIndex);
    });
  }

  void _scrollToIndex(int index) {
    final double itemWidth =
        widget.width ??
        (widget.items.length == 1
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * 0.80);
    final double targetOffset = (index * itemWidth).clamp(
      0.0, // Minimum scroll offset
      _scrollController.position.maxScrollExtent, // Maximum scroll offset
    );

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _updateCurrentIndex() {
    final double itemWidth =
        widget.width ??
        (widget.items.length == 1
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * 0.80);
    int newIndex = (_scrollController.offset / itemWidth).round();

    // Clamp the newIndex to the valid range
    newIndex = newIndex.clamp(0, widget.items.length - 1);

    if (newIndex != _currentIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.height,
          child: ListView.builder(
            cacheExtent: Platform.isIOS ? widget.height * 2 : double.infinity,
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            // physics: const PageScrollPhysics(),
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return widget.itemBuilder(widget.items[index]);
            },
          ),
        ),
        if (widget.showIndicator) const SizedBox(height: 10),
        if (widget.showIndicator)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.items.length, (index) {
              return InkWell(
                onTap: () {
                  _currentIndex = index;
                  _scrollToIndex(index);
                  setState(() {});
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 12 : 10,
                  height: 12,
                  decoration: BoxDecoration(
                    color:
                        _currentIndex == index
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
