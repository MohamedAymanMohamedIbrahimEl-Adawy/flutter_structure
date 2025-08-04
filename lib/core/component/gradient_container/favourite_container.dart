import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cleanarchitecture/core/component/image/p_image.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/data/app_dimensions/app_dimensions.dart';
import 'package:cleanarchitecture/core/data/assets_helper/app_svg_icon.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';
import 'package:cleanarchitecture/core/services/url_launcher/url_launcher_manager.dart';

class CircleGradientContainer extends StatelessWidget {
  final String icon;
  final String title;
  final String? description;
  final String? url;
  final bool isVertical;
  final bool? showDivider;
  final int? length;
  final String redirect;
  final bool isFromHome;
  const CircleGradientContainer({
    super.key,
    required this.icon,
    required this.title,
    this.showDivider = false,
    required this.redirect,
    required this.isVertical,
    this.description,
    this.length,
    this.isFromHome = false,
    this.url = '',
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          isFromHome
              ? null
              : () {
                if ((url ?? '').isNotEmpty) {
                  UrlLauncherManager.redirectUrl(
                    'http://selfservices.ipa.edu.sa/',
                  );
                } else {
                  if (redirect.isNotEmpty) {
                    if (title.contains('news'.tr()) ||
                        title.contains('events'.tr())) {
                      context.push(
                        redirect,
                        extra: title.contains('news'.tr()) ? true : false,
                      );
                    } else {
                      context.push(redirect);
                    }
                  }
                }
              },
      child: Container(
        padding: isFromHome ? const EdgeInsets.all(10) : null,
        alignment: Alignment.topCenter,
        width: isFromHome ? 120 : null,
        decoration:
            isFromHome
                ? BoxDecoration(
                  color:
                      isDarkContext(context)
                          ? AppColors.darkFieldBackgroundColor
                          : Colors.grey[50],
                  border: Border.all(
                    color:
                        isDarkContext(context)
                            ? AppColors.darkBorderColor
                            : AppColors.grayColor200,
                  ),
                  borderRadius: BorderRadius.circular(4),
                )
                : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            isFromHome
                ? GradientContainer(isVertical: isVertical, icon: icon)
                : Row(
                  children: [
                    GradientContainer(isVertical: isVertical, icon: icon),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PText(
                            title: description ?? '',
                            size: PSize.text16,
                            fontWeight: FontWeight.w600,
                            fontColor:
                                isDark
                                    ? AppColors.whiteColor
                                    : AppColors.contentColor,
                          ),
                          SizedBox(height: AppDimensions.margin8),
                          PText(
                            title: title,
                            size: PSize.text16,
                            fontWeight: FontWeight.w600,
                            fontColor:
                                isDark
                                    ? AppColors.whiteColor
                                    : AppColors.titleColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            if (showDivider ?? false)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Divider(),
              ),
            if (!isVertical)
              PText(
                maxLines: 2,
                title: title,
                overflow: TextOverflow.visible,
                size: PSize.text14,
                alignText: TextAlign.center,
                fontWeight: FontWeight.w500,
              ),
          ],
        ),
      ),
    );
  }
}

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
    required this.isVertical,
    required this.icon,
  });

  final bool isVertical;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      width: isVertical ? 50 : 65,
      height: isVertical ? 55 : 65,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppColors.secondaryColor, AppColors.primaryColor],
        ),
      ),
      child: Center(
        child: Container(
          width: isVertical ? 45 : 58,
          height: isVertical ? 52 : 58,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                isDarkContext(context)
                    ? AppColors.darkBackgroundColor
                    : AppColors.whiteColor, // Inner circle color
          ),
          child: Center(
            child: PImage(
              fit: BoxFit.cover,
              source: icon,
              width:
                  isVertical
                      ? null
                      : (icon == AppSvgIcons.reward ||
                              icon == AppSvgIcons.support ||
                              icon == AppSvgIcons.convertNumber ||
                              icon == AppSvgIcons.icMap ||
                              icon == AppSvgIcons.favourite
                          ? 20
                          : 30),
              height:
                  isVertical
                      ? null
                      : (icon == AppSvgIcons.reward ||
                              icon == AppSvgIcons.support ||
                              icon == AppSvgIcons.convertNumber ||
                              icon == AppSvgIcons.icMap ||
                              icon == AppSvgIcons.favourite
                          ? 20
                          : 30),
              color:
                  isDarkContext(context)
                      ? AppColors.whiteColor
                      : AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
