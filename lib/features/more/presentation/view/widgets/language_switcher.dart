import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/services/localization/app_localization.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(
        AppLocalization.isArabic ? 'English' : 'العربية',
        style: Theme.of(context).textTheme.labelLarge,
      ),
      onTap: () {
        context.setLocale(
          AppLocalization.isArabic
              ? const Locale('en', "US")
              : const Locale("ar", "DZ"),
        );
      },
    );
  }
}
