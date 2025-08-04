import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/custom_loader/custom_loader.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/data/constants/global_obj.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';

Widget customLoader({double? size, LoadingShape? loadingShape}) {
  return CustomLoader(
    loadingShape: loadingShape ?? LoadingShape.fadingCircle,
    color: Theme.of(Get.context!).colorScheme.inversePrimary,
    // color: isDark?AppColors.whiteColor:AppColors.primaryColor,
    size: size ?? 50,
  );
}

Decoration commonDecoration({
  Color? color,
  Gradient? gradient,
  Color shadowColor = Colors.transparent,
  double spreadRadius = 5,
  double blurRadius = 0,
  Offset offset = const Offset(0, 4),
  Color? borderColor,
  double borderRadius = 4.0,
}) {
  return BoxDecoration(
    color:
        color ?? (isDark ? AppColors.darkFieldBackgroundColor : Colors.white),
    gradient: gradient,
    boxShadow: [
      BoxShadow(
        color: shadowColor,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        offset: offset,
      ),
    ],
    border: Border.all(
      color:
          borderColor ??
          (isDark ? AppColors.darkBorderColor : AppColors.grayColor200),
    ),
    borderRadius: BorderRadius.circular(borderRadius),
  );
}
