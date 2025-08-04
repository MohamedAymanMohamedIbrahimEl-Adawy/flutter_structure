import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/global_widgets.dart';
import 'package:cleanarchitecture/core/component/image/p_image.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';

class ServiceRequestItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isVisible;
  final VoidCallback? onTap;

  const ServiceRequestItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isVisible,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: commonDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              SizedBox(
                height: 45,
                width: 50,
                child: CircleAvatar(
                  backgroundColor:
                      isDark ? AppColors.darkBackgroundColor : AppColors.shade1,
                  radius: 30,
                  child: PImage(
                    source: icon,
                    // height: 18,
                    // width: 18,
                    // fit: BoxFit.fill,
                    color:
                        isDark ? AppColors.whiteColor : AppColors.primaryColor,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: PText(
                  title: label,
                  size: PSize.text14,
                  fontColor:
                      isDark ? AppColors.whiteColor : AppColors.titleColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
