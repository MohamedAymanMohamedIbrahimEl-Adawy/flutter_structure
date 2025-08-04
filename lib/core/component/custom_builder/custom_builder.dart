import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleanarchitecture/core/global/state/base_state.dart';
import '../../global/enums/global_enum.dart';
import '../custom_loader/custom_loader.dart';

class CustomBlocBuilder<B extends BlocBase<S>, S> extends StatelessWidget {
  final Widget successWidget;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final Widget? initWidget;
  const CustomBlocBuilder({
    super.key,
    required this.successWidget,
    this.errorWidget,
    this.loadingWidget,
    this.emptyWidget,
    this.initWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        if (state is LoadedState) {
          return successWidget;
        } else if (state is LoadingState) {
          return loadingWidget ??
              const Center(
                child: CustomLoader(loadingShape: LoadingShape.wave),
              );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
