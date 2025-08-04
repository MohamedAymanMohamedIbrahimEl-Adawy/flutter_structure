import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PPagedListView<T> extends StatelessWidget {
  final PagingController<int, T> pagingController;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? emptyWidget;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final Axis scrollDirection;

  const PPagedListView({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
    this.padding,
    this.physics,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, T>(
      pagingController: pagingController,
      padding: padding,
      physics: physics,
      scrollDirection: scrollDirection,
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: itemBuilder,
        firstPageProgressIndicatorBuilder: (_) =>
        loadingWidget ?? const Center(child: CircularProgressIndicator()),
        newPageProgressIndicatorBuilder: (_) =>
        loadingWidget ?? const Center(child: CircularProgressIndicator()),
        firstPageErrorIndicatorBuilder: (_) => errorWidget ??
            const Center(
              child: Text(
                'Something went wrong. Tap to retry.',
                style: TextStyle(color: Colors.red),
              ),
            ),
        noItemsFoundIndicatorBuilder: (_) =>
        emptyWidget ?? const Center(child: Text('No items found.')),
      ),
    );
  }
}
