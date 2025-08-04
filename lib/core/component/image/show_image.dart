import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/image/p_image.dart';
import '../../data/constants/global_obj.dart';

enum ImageExtenstion { png, svg }

enum ImageType { network, asset, memory, file }

void showImage({
  required dynamic image,
  final dynamic file,
  final bool isFile = false,
}) {
  Navigator.of(Get.context!).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, _, __) {
        return Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: GestureDetector(
              child: Hero(
                tag: isFile ? file.toString() : image.toString(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close),
                    ),
                    PImage(
                      source: image,
                      file: file,
                      isFile: isFile,
                      height: 300,
                      width: 300,
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 700),
    ),
  );
}
