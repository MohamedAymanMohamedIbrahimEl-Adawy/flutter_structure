import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';

import 'show_bottom_sheet_image.dart';

class TakeImageLayout extends StatelessWidget {
  final String text;
  final dynamic controller;
  final BuildContext context;
  final double width;
  final double height;

  const TakeImageLayout({
    super.key,
    required this.text,
    required this.controller,
    required this.context,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return controller.imageName == ''
        ? GestureDetector(
          onTap: () {
            BottomSheetImage(controller: controller);
          },
          child: Container(
            width: width - 20,
            height: height * 0.35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 3, color: AppColors.primaryColor),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.3,
                  child: const Icon(
                    Icons.add_a_photo,
                    size: 100,
                    color: AppColors.primaryColor,
                  ),
                ),
                PText(title: text, size: PSize.text16),
              ],
            ),
          ),
        )
        : Container(
          alignment: Alignment.topRight,
          height: height * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: AppColors.primaryColor),
            image: DecorationImage(
              image: FileImage(controller.file),
              fit: BoxFit.fill,
            ),
          ),
          child: GestureDetector(
            onTap: () {
              controller.clearImage();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Icon(Icons.close, size: 35, color: AppColors.primaryColor),
                  Text(
                    'remove',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
