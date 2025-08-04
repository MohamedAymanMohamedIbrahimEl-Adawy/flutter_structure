import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/global/global_func.dart';
import '../../../../../core/services/theme/theme_cubit.dart';

class ThemeSwitcherButton extends StatelessWidget {
  const ThemeSwitcherButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        (isDark ? 'darkMode' : 'lightMode').tr(),
        style: Theme.of(context).textTheme.labelLarge,
      ),
      trailing: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder:
            (child, animation) => RotationTransition(
              turns:
                  child.key == const ValueKey('moon')
                      ? Tween<double>(begin: 0.75, end: 1).animate(animation)
                      : Tween<double>(begin: 0.75, end: 1).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            ),
        child: IconButton(
          key: isDark ? const ValueKey('moon') : const ValueKey('sun'),
          icon: Icon(isDark ? Icons.nightlight_round : Icons.wb_sunny),
          onPressed: () {
            context.read<ThemeCubit>().toggleTheme();
            final brightness = Theme.of(context).brightness;
            setSystemNavigationBarColor(
              isDarkMode: brightness != Brightness.dark,
            );
          },
        ),
      ),
    );
  }
}
