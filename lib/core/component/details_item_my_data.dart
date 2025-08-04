import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';

class DetailsItemMyData extends StatelessWidget {
  final String title;
  final String description;
  final bool isOdd;
  final TextDirection? textDirection;
  const DetailsItemMyData({
    super.key,
    required this.title,
    this.isOdd = false,
    required this.description,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading:
          isOdd
              ? Container(
                color:
                    isDark ? AppColors.darkBorderColor : AppColors.contentColor,
                height: 27,
                width: 1,
              )
              : null,
      trailing: null,
      minVerticalPadding: 0,
      horizontalTitleGap: 0,
      visualDensity: VisualDensity.compact,
      dense: true,
      title: PText(
        title: title,
        size: PSize.text12,
        fontWeight: FontWeight.w600,
        fontColor: AppColors.contentColor,
      ),
      subtitle: PText(
        title: description,
        textDirection: textDirection,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        size: PSize.text14,
        fontWeight: FontWeight.w600,
        fontColor: isDark ? AppColors.whiteColor : AppColors.titleColor,
      ),
    );
  }
}
