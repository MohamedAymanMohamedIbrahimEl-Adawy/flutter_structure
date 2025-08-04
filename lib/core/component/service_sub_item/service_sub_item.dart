import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';

import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../text/p_text.dart';

class ServiceSubItem extends StatelessWidget {
  final String title;
  final String? value;
  final Color? titleColor;
  final Color? valueColor;
  final FontWeight? valueFontWeight;
  const ServiceSubItem({
    super.key,
    required this.title,
    this.value,
    this.titleColor,
    this.valueFontWeight,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PText(
          title: title.tr(),
          fontWeight: FontWeight.w700,
          size: PSize.text12,
          fontColor:
              titleColor ??
              (isDarkContext(context)
                  ? AppColors.darkPrimaryColor
                  : AppColors.primaryColor),
        ),
        const SizedBox(height: 4),
        if (value != 'empty')
          PText(
            title: value ?? '',
            fontWeight: valueFontWeight ?? FontWeight.w700,
            size: PSize.text14,
            fontColor:
                isDarkContext(context)
                    ? AppColors.whiteColor
                    : (valueColor ?? AppColors.contentColor),
          ),
      ],
    );
  }
}
