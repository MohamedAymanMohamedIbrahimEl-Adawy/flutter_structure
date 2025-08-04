import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/image/p_image.dart';
import 'package:cleanarchitecture/core/data/assets_helper/app_svg_icon.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';
import 'package:cleanarchitecture/core/services/localization/app_localization.dart';

import '../../data/constants/global_obj.dart';

class PToast {
  static void showToast({
    BuildContext? context,
    required String message,
    MessageType type = MessageType.success,
    Color backgroundColor = AppColors.successCode,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
  }) {
    OverlayEntry? overlayEntry;
    final controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: Navigator.of(context ?? Get.context!),
    );

    final opacity = Tween(begin: 0.0, end: 1.0).animate(controller);

    overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top:
                position == ToastPosition.center
                    ? MediaQuery.sizeOf(context).height * 0.50
                    : (position == ToastPosition.top ? 50 : null),
            bottom: position == ToastPosition.bottom ? 16 : null,
            left: 18,
            right: 18,
            child: FadeTransition(
              opacity: opacity,
              child: _buildToastLayout(
                type,
                message,
                backgroundColor,
                textColor,
              ),
            ),
          ),
    );

    // Insert the overlay
    Overlay.of(context ?? Get.context!).insert(overlayEntry);

    // Start the fade-in animation
    controller.forward();

    // Remove the overlay after the duration with fade-out animation
    Future.delayed(duration, () {
      controller.reverse().then((value) => overlayEntry?.remove());
    });
  }
}

Widget _buildToastLayout(
  MessageType type,
  String message,
  Color backgroundColor,
  Color textColor,
) {
  return Material(
    color: Colors.transparent,
    child: Container(
      decoration: BoxDecoration(
        color: getColorByType(type),
        borderRadius: BorderRadius.circular(4),
        boxShadow:
            isDark
                ? null
                : const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            // if(type==MessageType.success)Container(color:AppColors.successTextColor,width:3.5,height:50,),
            // if (type == MessageType.success)
            Container(color: AppColors.whiteColor, width: 3.5, height: 60),
            const SizedBox(width: 10),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getColorTints(type),
              ),
              child: getIcon(type),
            ),
            type == MessageType.success
                ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        // Container(
                        //   width: 20, // Adjust size as needed
                        //   height: 20, // Adjust size as needed
                        //   decoration: const BoxDecoration(
                        //     color: AppColors.successColor, // Background color
                        //     shape: BoxShape.circle, // Circular shape
                        //   ),
                        //   child: const Icon(
                        //     Icons.check,
                        //     color: Colors.white, // Checkmark color
                        //     size: 16, // Adjust size as needed
                        //   ),
                        // ),
                        const SizedBox(width: 6),
                        Expanded(
                          // Ensure text takes only the available space
                          child: Text(
                            message,
                            textDirection: TextDirection.rtl,
                            textAlign:
                                AppLocalization.isArabic
                                    ? TextAlign.right
                                    : TextAlign.left,
                            style: Theme.of(
                              Get.context!,
                            ).textTheme.labelLarge?.copyWith(
                              fontSize: 14,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                : Expanded(
                  child: Row(
                    children: [
                      const SizedBox(width: 10), // Add spacing
                      Expanded(
                        // Ensure text takes only the available space
                        child: Text(
                          message,
                          textAlign:
                              AppLocalization.isArabic
                                  ? TextAlign.right
                                  : TextAlign.left,
                          style: Theme.of(Get.context!).textTheme.labelLarge
                              ?.copyWith(color: AppColors.whiteColor),
                        ),
                      ),
                    ],
                  ),
                ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    ),
  );
}

class SafeToast {
  static void show({
    required String message,
    Color textColor = Colors.white,
    MessageType type = MessageType.success,
    Duration duration = const Duration(seconds: 2),
  }) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    final backgroundColor = getColorByType(type);

    ScaffoldMessenger.of(context).clearSnackBars(); // clear old ones
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        content: _buildToastLayout(type, message, backgroundColor, textColor),
        elevation: 0,
        backgroundColor: Colors.transparent,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}

Color getColorByType(MessageType type) {
  if (type == MessageType.success) {
    return AppColors.newSuccessColor;
  } else if (type == MessageType.error) {
    return AppColors.newErrorColor;
  } else if (type == MessageType.warning) {
    return AppColors.newWarningColor;
  } else if (type == MessageType.info) {
    return Colors.black54;
  } else {
    return Colors.black;
  }
}

Color getColorTints(MessageType type) {
  if (type == MessageType.success) {
    return AppColors.newSuccessTintColor;
  } else if (type == MessageType.error) {
    return AppColors.newErrorTintColor;
  } else if (type == MessageType.warning) {
    return AppColors.newWarningTintColor;
  } else if (type == MessageType.info) {
    return Colors.black54;
  } else {
    return Colors.black;
  }
}

Widget getIcon(MessageType type) {
  if (type == MessageType.success) {
    return const PImage(source: AppSvgIcons.icSuccess);
  } else if (type == MessageType.error) {
    return const PImage(source: AppSvgIcons.icError);
  } else if (type == MessageType.warning) {
    return const PImage(source: AppSvgIcons.icWarning);
  } else {
    return const PImage(source: AppSvgIcons.icSuccess);
  }
}

// import 'package:flutter/material.dart';
// import 'package:cleanarchitecture/core/component/image/p_image.dart';
// import 'package:cleanarchitecture/core/data/assets_helper/app_icon.dart';
// import 'package:cleanarchitecture/core/data/assets_helper/app_svg_icon.dart';
// import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
// import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
// import 'package:cleanarchitecture/core/global/global_func.dart';
// import 'package:cleanarchitecture/core/services/localization/app_localization.dart';
//
// import '../../data/constants/global_obj.dart';
//
// class PToast {
//   static void showToast({
//     BuildContext? context,
//     required String message,
//     MessageType type = MessageType.success,
//     Color backgroundColor = AppColors.successCode,
//     Color textColor = Colors.white,
//     Duration duration = const Duration(seconds: 2),
//     ToastPosition position = ToastPosition.bottom,
//   }) {
//     OverlayEntry? overlayEntry;
//     final controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: Navigator.of(context ?? Get.context!),
//     );
//
//     final opacity = Tween(begin: 0.0, end: 1.0).animate(controller);
//
//     overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: position == ToastPosition.center
//             ? MediaQuery.sizeOf(context).height * 0.50
//             : (position == ToastPosition.top ? 50 : null),
//         bottom: position == ToastPosition.bottom ? 16 : null,
//         left: 18,right: 18,
//         child: FadeTransition(
//           opacity: opacity,
//           child: _buildToastLayout(
//             type,
//             message,
//             backgroundColor,
//             textColor,
//           ),
//         ),
//       ),
//     );
//
//     // Insert the overlay
//     Overlay.of(context ?? Get.context!).insert(overlayEntry);
//
//     // Start the fade-in animation
//     controller.forward();
//
//     // Remove the overlay after the duration with fade-out animation
//     Future.delayed(duration, () {
//       controller.reverse().then((value) => overlayEntry?.remove());
//     });
//   }
//
//   static Widget _buildToastLayout(MessageType type, String message,
//       Color backgroundColor, Color textColor) {
//     return Material(
//       color: Colors.transparent,
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           // vertical: type == MessageType.success ? 0 : 12,
//             // horizontal: type == MessageType.success ? 0 : 24
//         ),
//         decoration: BoxDecoration(
//           color: getColorByType(type),
//           borderRadius: BorderRadius.circular(4),
//           boxShadow: isDark? null:const [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 2,
//               offset: Offset(0, 1),
//             ),
//           ],
//         ),
//         child: Directionality(
//           textDirection: TextDirection.rtl,
//           child: Row(
//             children: [
//               // if(type==MessageType.success)Container(color:AppColors.successTextColor,width:3.5,height:50,),
//               // if (type == MessageType.success)
//                 Container(
//                   color: type == MessageType.success?AppColors.successColor:
//                   isDark?AppColors.errorCode:AppColors.whiteColor,
//                   width: 3.5, height: 50,
//                 ),const SizedBox(width:4,),
//               if (type == MessageType.success)
//                 const SizedBox(
//                   width: 10,
//                 ),
//               if (type == MessageType.success)
//                 const PImage(
//                   source: AppSvgIcons.iconSuccess,
//                   width: 20,
//                   height: 20,
//                   color: AppColors.successColor,
//                 ),
//               if (type == MessageType.success)
//                 const SizedBox(
//                   width: 10,
//                 ),
//               type == MessageType.success
//                   ? Expanded(
//                       child: Row(
//                         children: [
//                           // Container(
//                           //   width: 20, // Adjust size as needed
//                           //   height: 20, // Adjust size as needed
//                           //   decoration: const BoxDecoration(
//                           //     color: AppColors.successColor, // Background color
//                           //     shape: BoxShape.circle, // Circular shape
//                           //   ),
//                           //   child: const Icon(
//                           //     Icons.check,
//                           //     color: Colors.white, // Checkmark color
//                           //     size: 16, // Adjust size as needed
//                           //   ),
//                           // ),
//                           const SizedBox(width: 6),
//                           Expanded(
//                             // Ensure text takes only the available space
//                             child: Text(
//                               message,
//                               textDirection: TextDirection.rtl,
//                               textAlign: AppLocalization.isArabic
//                                   ? TextAlign.right
//                                   : TextAlign.left,
//                               style: Theme.of(Get.context!)
//                                   .textTheme
//                                   .labelLarge
//                                   ?.copyWith(fontSize:14,
//                                     color: isDark
//                                         ? AppColors.successTextColor
//                                         : AppColors.successTextColor,
//                                   ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : Expanded(
//                       child: Row(
//                         children: [
//                           Container(margin: const EdgeInsets.only(right:4),
//                             width: 20, // Adjust size as needed
//                             height: 20, // Adjust size as needed
//                             decoration:  BoxDecoration(
//                               color: isDark?AppColors.errorCode:AppColors.whiteColor, // Background color
//                               shape: BoxShape.circle, // Circular shape
//                             ),
//                             child:  Icon(
//                               Icons.close,
//                               color: isDark?Colors.white:AppColors.errorCode, // Checkmark color
//                               size: 16, // Adjust size as needed
//                             ),
//                           ),
//                           const SizedBox(width: 10), // Add spacing
//                           Expanded(
//                             // Ensure text takes only the available space
//                             child: Text(
//                               message,
//                               textAlign: AppLocalization.isArabic
//                                   ? TextAlign.right
//                                   : TextAlign.left,
//                               style: Theme.of(Get.context!)
//                                   .textTheme
//                                   .labelLarge
//                                   ?.copyWith(
//                                     color: isDark
//                                         ? AppColors.errorCode
//                                         : AppColors.whiteColor,
//                                   ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//               const SizedBox(width:10,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// Color getColorByType(MessageType type) {
//   if (type == MessageType.success) {
//     // return AppColors.successBackgroundColor;
//     return isDark ? AppColors.darkFieldBackgroundColor : AppColors.successBackgroundColor;
//   } else if (type == MessageType.error) {
//     return isDark ? AppColors.darkFieldBackgroundColor : Colors.red;
//   } else if (type == MessageType.warning) {
//     return Colors.orange;
//   } else if (type == MessageType.info) {
//     return Colors.black54;
//   } else {
//     return Colors.black;
//   }
// }
