import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppAlerts {
  static Future<dynamic> showAlertNoAction({
    required String title,
    required BuildContext context,
    String buttonTitle = 'okay',
    String? outputAction,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog.adaptive(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              25,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: 8,
                ),
                child: Text(
                  title.tr(),
                  textScaler: const TextScaler.linear(1),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(outputAction);
                          },
                          child: Text(
                            buttonTitle.tr(),
                            textScaler: const TextScaler.linear(1),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<dynamic> showAlertYesOrNo({
    required String title,
    required BuildContext context,
    String actionButtonTitleYes = 'yes',
    String actionButtonTitleNo = 'no',
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog.adaptive(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 4,
                bottom: 8,
              ),
              child: Text(
                title.tr(),
                textScaler: const TextScaler.linear(1),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16,
                    ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(
                        actionButtonTitleYes.tr(),
                        textScaler: const TextScaler.linear(1),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(
                        actionButtonTitleNo.tr(),
                        textScaler: const TextScaler.linear(1),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  static Future<dynamic> showCustomDialog({
    required BuildContext context,
    required Widget contentWidget,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog.adaptive(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              25,
            ),
          ),
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          content: contentWidget,
        );
      },
    );
  }
}
