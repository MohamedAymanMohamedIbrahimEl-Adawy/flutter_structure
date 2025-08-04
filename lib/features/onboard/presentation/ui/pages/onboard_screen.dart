import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/data/constants/app_router.dart';
import 'package:cleanarchitecture/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:cleanarchitecture/features/onboard/data/model/onboard_model.dart';
import '../../../../../core/component/button/p_button.dart';
import '../../../../../core/data/assets_helper/app_svg_icon.dart';
import '../../../../../core/data/constants/shared_preferences_constants.dart';
import '../../../../../core/global/enums/global_enum.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  OnboardScreenState createState() => OnboardScreenState();
}

class OnboardScreenState extends State<OnboardScreen>
    with SingleTickerProviderStateMixin {
  final List<OnboardModel> onboardList = [
    OnboardModel(
      title: 'onboard_title_1',
      body: 'onboard_body_1',
      imagePath: AppSvgIcons.onbaord1,
    ),
    OnboardModel(
      title: 'onboard_title_2',
      body: 'onboard_body_2',
      imagePath: AppSvgIcons.onbaord2,
    ),
    OnboardModel(
      title: 'onboard_title_3',
      body: 'onboard_body_3',
      imagePath: AppSvgIcons.onbaord3,
    ),
  ];
  late final PageController pageController;
  late final TabController tabController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    tabController = TabController(
      length: onboardList.length,
      initialIndex: _index,
      animationDuration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    pageController.dispose();
  }

  void _onDotTapped(int index) {
    // This function will handle the tap on a dot (tab)
    tabController.animateTo(index); // Update the tab selection programmatically
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                itemCount: onboardList.length,
                onPageChanged: (value) {
                  _index = value;
                  tabController.animateTo(_index);
                },
                itemBuilder:
                    (context, index) =>
                        PageItem(onboardModel: onboardList[index]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PRoundedButton(
                  onPressed: () {
                    SharedPreferenceService().setBool(
                      SharPrefConstants.isFirstTimeToOpenAppKey,
                      false,
                    );
                    context.goNamed(AppRouter.login);
                  },
                  title: 'skip'.tr(),
                  textColor: AppColors.titleColor,
                  size: PSize.text14,
                  borderRadius: 0,
                  backgroundColor: Colors.transparent,
                ),
                GestureDetector(
                  onTap: () => _onDotTapped(0), // Tap the first dot
                  child: TabPageSelector(
                    color: AppColors.inactiveDotColor,
                    selectedColor: AppColors.primaryColor,
                    borderStyle: BorderStyle.none,
                    controller: tabController,
                  ),
                ),
                PRoundedButton(
                  onPressed: () async {
                    if (_index == onboardList.length - 1) {
                      SharedPreferenceService().setBool(
                        SharPrefConstants.isFirstTimeToOpenAppKey,
                        false,
                      );
                      context.goNamed(AppRouter.login);
                    } else {
                      _index++;
                      tabController.animateTo(_index);
                      pageController.animateToPage(
                        _index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  title: 'next'.tr(),
                  size: PSize.text14,
                  borderRadius: 0,
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PageItem extends StatelessWidget {
  final OnboardModel onboardModel;
  const PageItem({super.key, required this.onboardModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SvgPicture.asset(
              onboardModel.imagePath,
              height: 370,
              fit: BoxFit.contain,
            ),
          ),
          Center(
            child: SvgPicture.asset(AppSvgIcons.ellipse, fit: BoxFit.contain),
          ),
          const SizedBox(height: 24),
          PText(
            title: onboardModel.title.tr(),
            size: PSize.text18,
            fontWeight: FontWeight.w700,
            fontColor: AppColors.titleColor,
          ),
          Container(
            height: 3,
            width: 80,
            margin: const EdgeInsets.symmetric(vertical: 24),
            decoration: const BoxDecoration(color: AppColors.primaryColor),
          ),
          PText(
            title: onboardModel.body.tr(),
            size: PSize.text16,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.neutralColor50,
          ),
        ],
      ),
    );
  }
}
