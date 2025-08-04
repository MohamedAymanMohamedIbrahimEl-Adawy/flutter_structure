import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/image/p_image.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';

class MoreItem extends StatelessWidget {
  const MoreItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.iconSize = 20,
  });
  final String title;
  final String icon;
  final double iconSize;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            PImage(
              source: icon,
              color: AppColors.primaryColor,
              width: iconSize,
              height: iconSize,
            ),
            const SizedBox(width: 6),
            PText(
              title: title.tr(),
              size: PSize.text14,
              fontWeight: FontWeight.w500,
              // fontColor: AppColors.titleColor,
            ),
          ],
        ),
      ),
    );
  }
}
