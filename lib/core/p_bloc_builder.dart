import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleanarchitecture/core/component/global_widgets.dart';
import 'package:cleanarchitecture/core/component/image/p_image.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/data/assets_helper/app_icon.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';
import 'package:cleanarchitecture/core/global/state/base_state.dart';

class PBlocBuilder<B extends BlocBase<S>, S> extends StatelessWidget {
  final B bloc;
  final VoidCallback? init;
  final double? width;
  final double topPadding;
  final double bottomPadding;
  final double? height;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? emptyWidget;
  final Widget Function(S state) loadedWidget;
  final bool isCircularLoading;

  const PBlocBuilder({
    super.key,
    required this.bloc,
    this.init,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
    this.topPadding = 20,
    this.bottomPadding = 20,
    this.width,
    this.height,
    required this.loadedWidget,
    this.isCircularLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc, // Use value if the bloc is already provided
      child: BlocBuilder<B, S>(
        buildWhen:
            (previous, current) =>
                current is InitialState ||
                current is LoadingState ||
                current is LoadedState ||
                current is EmptyState ||
                current is ErrorState,
        builder: (context, state) {
          if (state is InitialState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              init?.call();
            });
            return const SizedBox.shrink();
          } else if (state is LoadingState) {
            return loadingWidget ??
                (isCircularLoading
                    ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: customLoader(),
                    )
                    : ShimmerPlaceholder(
                      width: width ?? double.infinity,
                      height: height ?? 100,
                    )
                // Skeletonizer(
                //         enabled: true,
                //         child: Container(
                //           width: width ?? double.infinity,
                //           height: height ?? 100,
                //           color: isDark
                //               ? AppColors.darkFieldBackgroundColor
                //               : const Color(0xffEBEBF3),
                //           child: const SizedBox.shrink(), // Ensures visibility
                //         ),
                //       )
                );
          } else if (state is LoadedState) {
            return loadedWidget(state);
          } else if (state is EmptyState) {
            return emptyWidget ??
                EmptyWidget(title: state.data ?? 'لا يوجد بيانات');
          } else if (state is ErrorState) {
            return errorWidget ??
                Padding(
                  padding: EdgeInsets.only(
                    top: topPadding,
                    bottom: bottomPadding,
                  ),
                  child: GestureDetector(
                    onTap: init,
                    child: Center(
                      child: Text(
                        state.data?.message ?? 'حدث خطأ ما',
                        style: TextStyle(
                          color:
                              isDark ? AppColors.whiteColor : AppColors.black,
                        ),
                      ),
                    ),
                  ),
                );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  final String? title;
  const EmptyWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const PImage(
          source: AppIcons.noData,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
        PText(
          title: title ?? 'لا يوجد بيانات',
          size: PSize.text16,
          fontColor: isDark ? AppColors.whiteColor : AppColors.black,
        ),
      ],
    );
  }
}

























// class PBlocBuilder<B extends BlocBase<S>, S> extends StatelessWidget {
//   final B bloc;
//   final VoidCallback? init;
//   final double? width;
//   final double topPadding;
//   final double bottomPadding;
//   final double? height;
//   final Widget? loadingWidget;
//   final Widget? errorWidget;
//   final Widget? emptyWidget;
//   final Widget Function(S state) loadedWidget;
//   final bool isCircularLoading;
//
//   const PBlocBuilder({
//     super.key,
//     required this.init,
//     this.loadingWidget,
//     this.errorWidget,
//     this.emptyWidget,
//     this.topPadding = 20,
//     this.bottomPadding = 20,
//     this.width,
//     this.height,
//     required this.loadedWidget,
//     required this.bloc,
//     this.isCircularLoading = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<B>(
//       create: (_) => bloc,
//       child: BlocBuilder<B, S>(
//         buildWhen: (previous, current) => (current is InitialState ||
//             current is LoadingState ||
//             current is LoadedState ||
//             current is EmptyState ||
//             current is ErrorState),
//         builder: (context, state) {
//           if (state is InitialState) {
//             if (init != null) {
//               init!();
//             }
//             return const Center(child: SizedBox());
//           } else if (state is LoadingState) {
//             return loadingWidget ??
//                 (isCircularLoading
//                     ? Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 30,
//                   ),
//                   child: customLoader(),
//                 )
//                     : Skeletonizer(
//                   enabled: true,
//                   child: Container(
//                     width: width,
//                     height: height,
//                     color: const Color(0xffEBEBF3),
//                   ),
//                 ));
//             // return loadingWidget?? const Center(child: CircularProgressIndicator());
//           } else if (state is LoadedState) {
//             return loadedWidget(state);
//           } else if (state is EmptyState) {
//             return emptyWidget ??
//                 EmptyWidget(
//                   title: state.data,
//                 );
//           } else if (state is ErrorState) {
//             return errorWidget ??
//                 Padding(
//                   padding:
//                   EdgeInsets.only(top: topPadding, bottom: bottomPadding),
//                   child: GestureDetector(
//                     onTap: () {
//                       if (init != null) {
//                         init!();
//                       }
//                     },
//                     child: Center(
//                       child: Text(state.data?.message ?? ''),
//                     ),
//                   ),
//                 );
//           } else {
//             return const SizedBox.shrink();
//           }
//           // return builder(context, state);
//         },
//       ),
//     );
//   }
// }
//
// class EmptyWidget extends StatelessWidget {
//   final String? title;
//   const EmptyWidget({
//     super.key,
//     this.title,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const PImage(
//           source: AppIcons.noData,
//           width: 40,
//           height: 40,
//           fit: BoxFit.cover,
//         ),
//         PText(
//           title: title ?? 'لا يوجد بيانات',
//           size: PSize.text16,
//           fontColor: AppColors.black,
//         )
//       ],
//     );
//   }
// }