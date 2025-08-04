import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cleanarchitecture/core/component/bottom_navigation/bottom_nav_item.dart';
import 'package:cleanarchitecture/core/component/bottom_navigation/p_bottom_nav_bar.dart';
import 'package:cleanarchitecture/core/data/assets_helper/app_svg_icon.dart';
import 'package:cleanarchitecture/core/data/constants/app_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  CustomBottomNavigation({super.key, required this.navigationShell});
  final List<BottomNavItem> _navItems = [
    const BottomNavItem(
      icon: AppSvgIcons.home,
      redirect: AppRouter.home,
      label: 'home',
    ),
    const BottomNavItem(
      icon: AppSvgIcons.calendar,
      redirect: AppRouter.calendar,
      label: 'calendar',
    ),
    const BottomNavItem(
      icon: AppSvgIcons.profile,
      redirect: AppRouter.profile,
      label: 'profile',
    ),
    const BottomNavItem(
      icon: AppSvgIcons.more,
      redirect: AppRouter.more,
      label: 'more',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PBottomNavBar(
      items: _navItems,
      currentIndex: navigationShell.currentIndex,
      onTap: (value) {
        navigationShell.goBranch(value);
      },
    );
  }
}
