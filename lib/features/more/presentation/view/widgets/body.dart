import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/dialog/p_dialog.dart';
import 'package:cleanarchitecture/core/data/assets_helper/app_svg_icon.dart';

import 'package:cleanarchitecture/di.dart';
import 'package:cleanarchitecture/features/more/presentation/bloc/logout_bloc.dart';
import 'package:cleanarchitecture/features/more/presentation/view/widgets/more_item.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/data/constants/app_router.dart';
import '../../../../../core/data/constants/global_obj.dart';
import '../widgets/language_switcher.dart';
import '../widgets/theme_switcher.dart';

class Body extends StatelessWidget {
  const Body({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                MoreItem(
                  iconSize: 17,
                  title: 'map'.tr(),
                  icon: AppSvgIcons.icMap,
                  onTap: () {
                    Get.context!.pushNamed(AppRouter.communicationMapScreen);
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: Theme.of(context).dividerColor,
                      height: 1,
                    ),
                  ),
                  const LanguageSwitcher(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Divider(
                      color: Theme.of(context).dividerColor,
                      height: 1,
                    ),
                  ),
                  const ThemeSwitcherButton(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Divider(
                      color: Theme.of(context).dividerColor,
                      height: 1,
                    ),
                  ),
                  MoreItem(
                    title: 'logout',
                    icon: AppSvgIcons.logout,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PDialog(
                            screenContext: context,
                            logoutBloc: LogoutBloc(logoutUseCase: getIt()),
                            title: 'تسجيل الخروج',
                            description: 'هل أنت متأكد من تسجيل خروجك؟',
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
