import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/data/app_dimensions/app_dimensions.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';

class WideStatusCard extends StatelessWidget {
  final String title;
  const WideStatusCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppDimensions.padding10),
      padding: EdgeInsets.symmetric(
        vertical: AppDimensions.padding10,
        horizontal: AppDimensions.padding10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        // color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkFieldBackgroundColor : AppColors.shade2,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info,
            color: isDark ? AppColors.darkTitleColor : AppColors.primaryColor,
          ),
          const SizedBox(width: 10),
          PText(
            title: title.tr(),
            size: PSize.text14,
            fontColor:
                isDark ? AppColors.darkTitleColor : AppColors.primaryColor,
          ),
          const Spacer(),
          // const PImage(
          //   source: AppSvgIcons.ic_arrow_left,
          // )
        ],
      ),
    );
  }
}
