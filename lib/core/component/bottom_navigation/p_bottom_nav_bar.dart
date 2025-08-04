import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/bottom_navigation/bottom_nav_item.dart';
import 'package:cleanarchitecture/core/component/image/p_image.dart';
import 'package:cleanarchitecture/core/data/app_dimensions/app_dimensions.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';

class PBottomNavBar extends StatelessWidget {
  final List<BottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            // backgroundColor: Colors.white,
            elevation: 8,
            onTap: (value) => onTap(value),
            type: BottomNavigationBarType.fixed,
            mouseCursor: SystemMouseCursors.click,
            enableFeedback: false,
            selectedItemColor:
                isDarkContext(context)
                    ? AppColors.primaryColor
                    : AppColors.primaryColor,
            selectedLabelStyle: TextStyle(
              fontSize: AppDimensions.text14,
              fontFamily: 'Cairo',
              color:
                  isDarkContext(context)
                      ? AppColors.primaryColor
                      : AppColors.primaryColor,
              height: 1.4,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: AppDimensions.text14,
              fontFamily: 'Cairo',
              height: 1.4,
            ),

            items:
                items.mapIndexed((index, item) {
                  return BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: PImage(
                        source: item.icon,
                        width: 18,
                        height: 18,
                        color:
                            index == currentIndex
                                ? (isDarkContext(context)
                                    ? AppColors.primaryColor
                                    : AppColors.primaryColor)
                                : null,
                      ),
                    ),
                    label: item.label.tr(),
                  );
                }).toList(),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          left:
              context.locale.languageCode == 'en'
                  ? currentIndex * (screenWidth / 4)
                  : null,
          right:
              context.locale.languageCode == 'ar'
                  ? currentIndex * (screenWidth / 4)
                  : null,
          child: Container(
            width: screenWidth / 4,
            height: 1.4,
            color:
                isDarkContext(context)
                    ? AppColors.primaryColor
                    : AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
