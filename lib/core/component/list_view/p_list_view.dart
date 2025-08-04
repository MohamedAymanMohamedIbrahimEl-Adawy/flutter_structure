import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/global/state/base_state.dart';

class PListView<T> extends StatelessWidget {
  final BaseState state;
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget? emptyWidget;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool isScrollable;
  final Axis scrollDirection;

  const PListView({
    super.key,
    required this.state,
    required this.items,
    required this.itemBuilder,
    this.emptyWidget,
    this.padding,
    this.physics,
    this.isScrollable = true,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    if ((state is LoadedState) && items.isEmpty) {
      return emptyWidget ??
          const Center(
            child: Text(
              'No items available',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
    }
    return ListView.builder(
      padding: padding,
      physics: isScrollable ? physics : const NeverScrollableScrollPhysics(),
      scrollDirection: scrollDirection,
      itemCount: items.isEmpty ? 20 : items.length,
      itemBuilder: (context, index) {
        // if (items.isEmpty)
        //   return itemBuilder(context, CoursesResponseModelDatum() as T);
        final item = items[index];
        return itemBuilder(context, item);
      },
    );
  }
}
