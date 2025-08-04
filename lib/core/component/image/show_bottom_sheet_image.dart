import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';

class BottomSheetImage extends StatelessWidget {
  final dynamic controller;

  const BottomSheetImage({super.key, required this.controller});

  static void show(BuildContext context, dynamic controller) {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color:
              isDarkContext(context)
                  ? AppColors.darkFieldBackgroundColor
                  : AppColors.whiteColor,
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PText(title: 'Please Choose way', size: PSize.text16),
                Container(
                  margin: const EdgeInsets.only(
                    left: 4,
                    right: 4,
                    top: 10,
                    bottom: 10,
                  ),
                  height: 1,
                  width: width,
                  color: AppColors.primaryColor,
                ),
                InkWell(
                  onTap: () async {
                    controller.gallery();
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(Icons.perm_media_outlined),
                        SizedBox(width: 5),
                        PText(title: 'From Gallery', size: PSize.text16),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    controller.camera();
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        SizedBox(width: 5),
                        PText(title: 'From Camera', size: PSize.text16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
// gallery() async {
//   final imagePicker = ImagePicker();
//   final image = await imagePicker.pickImage(source: ImageSource.camera);
//   if (image != null) {
//     file = File(image.path);
//     imageName = basename(image.path);
//     Get.back();
//   } else {
//     Get.snackbar('Error', 'no image selected');
//   }
//   update();
// }

// camera() async {
//   final imagePicker = ImagePicker();
//   final image = await imagePicker.pickImage(source: ImageSource.camera);
//   if (image != null) {
//     file = File(image.path);
//     imageName = basename(image.path);
//     Get.back();
//   } else {
//     Get.snackbar('Error', 'no image selected');
//   }
//   update();
// }
