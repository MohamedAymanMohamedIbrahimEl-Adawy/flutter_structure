import 'package:flutter/material.dart';

import '../../data/constants/global_obj.dart';
import '../button/p_button.dart';

Future<dynamic> showCustomBottomSheet({
  BuildContext? context,
  required Widget body,
  bool withYesNoActions = false,
}) async {
  return showModalBottomSheet(
    context: context ?? Get.navigatorState!.context,
    isDismissible: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
    ),
    builder: (context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          body,
          const SizedBox(
            height: 32,
          ),
          withYesNoActions
              ? Row(
                  children: [
                    Expanded(
                      child: PButton(
                        hasBloc: false,
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        title: "نعم",
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: PButton(
                        hasBloc: false,
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        title: "لا",
                      ),
                    ),
                  ],
                )
              : PButton(
                  hasBloc: false,
                  isFitWidth: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  title: "حسناً",
                )
        ],
      ),
    ),
  );
}
