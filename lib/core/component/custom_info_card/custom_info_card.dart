import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cleanarchitecture/core/component/button/p_button.dart';
import 'package:cleanarchitecture/core/component/global_widgets.dart';
import 'package:cleanarchitecture/core/component/image/p_image.dart';
import 'package:cleanarchitecture/core/data/assets_helper/app_svg_icon.dart';
import 'package:cleanarchitecture/core/data/constants/app_router.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';
import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../service_sub_item/service_sub_item.dart';
import '../text/p_text.dart';

class CustomInfoCard extends StatelessWidget {
  final String? title;
  final List<ServiceSubItem> items;
  final Color? backgroundColor;
  final Color? dividerColor;
  final bool showButtons;
  final bool? hasDetailsButton;
  final EdgeInsetsGeometry? padding;

  final dynamic model;

  const CustomInfoCard({
    super.key,
    this.title,
    required this.items,
    this.backgroundColor,
    this.dividerColor,
    this.showButtons = false,
    this.hasDetailsButton = false,
    this.padding,
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      // padding:
      //     padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: commonDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Padding(
                padding:
                    padding ??
                    const EdgeInsets.only(left: 12, right: 12, top: 12),
                child: PText(
                  title: title!,
                  fontWeight: FontWeight.w700,
                  size: PSize.text14,
                ),
              )
              : const SizedBox.shrink(),
          SizedBox(height: title != null ? 16 : 10),
          Padding(
            padding:
                padding ??
                const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Column(
              children: [
                for (int i = 0; i < items.length; i += 2)
                  Row(
                    children: [
                      Expanded(child: items[i]),
                      if (i + 1 < items.length) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8,
                          ),
                          child: SizedBox(
                            height: 45,
                            child: VerticalDivider(
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                        ),
                        Expanded(child: items[i + 1]),
                      ],
                    ],
                  ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          if (showButtons)
            Row(
              children: [
                Expanded(
                  child: PButton(
                    borderRadiusGeometry: const BorderRadius.only(
                      bottomRight: Radius.circular(4),
                    ),
                    borderRadius: 0,
                    onPressed: () {
                      // context.push(AppRouter.deductionsScreen, extra: query);
                    },
                    title: 'الحسميات',
                    hasBloc: false,
                  ),
                ),
                Expanded(
                  child: PButton(
                    borderRadiusGeometry: const BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                    ),
                    borderRadius: 0,
                    onPressed: () {
                      // context.push(AppRouter.alternativesScreen, extra: query);
                    },
                    title: 'البدالات',
                    hasBloc: false,
                    fillColor: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
          if (hasDetailsButton ?? false)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Divider(
                height: 1,
                color: Theme.of(context).dividerColor.withValues(alpha: 0.4),
              ),
            ),
          if (hasDetailsButton ?? false)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: PButton(
                isFitWidth: true,
                isLeftIcon: true,
                onPressed: () {
                  context.push(AppRouter.deductionAlternative, extra: model);
                },
                hasBloc: false,
                fillColor: Colors.transparent,
                title: 'التفاصيل'.tr(),
                padding: EdgeInsets.zero,
                mainAxisSize: MainAxisSize.max,
                textColor:
                    isDark ? AppColors.whiteColor : AppColors.primaryColor,
                icon: PImage(
                  source: AppSvgIcons.ic_arrow_left,
                  color: isDark ? AppColors.whiteColor : AppColors.primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
