import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/inspector/inspector_model.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';

class RequestWidget extends StatelessWidget {
  final InspectorModel inspectorModel;
  const RequestWidget({super.key, required this.inspectorModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 6),
              child: Row(
                children: [
                  const PText(
                    title: 'Started :    ',
                    size: PSize.text16,
                    fontWeight: FontWeight.w700,
                  ),
                  PText(
                    title: inspectorModel.startTime ?? '',
                    size: PSize.text16,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 6),
              child: Row(
                children: [
                  const PText(
                    title: 'Content Type :    ',
                    size: PSize.text16,
                    fontWeight: FontWeight.w700,
                  ),
                  Expanded(
                    child: PText(
                      title: inspectorModel.contentType ?? '',
                      size: PSize.text16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 6),
              child: Row(
                children: [
                  const PText(
                    title: 'Body :    ',
                    size: PSize.text16,
                    fontWeight: FontWeight.w700,
                  ),
                  Expanded(
                    child: PText(
                      title:
                          // parseFormData(inspectorModel.responseBody),
                          ((inspectorModel.data ?? 'Body is Empty') is FormData)
                              ?
                              // parseFormData(inspectorModel.responseBody)
                              jsonEncode(
                                inspectorModel.data.fields
                                    .map((e) => {e.key: e.value})
                                    .toList(),
                              )
                              : (beautifyJsonString(
                                    inspectorModel.data ?? '',
                                  ) ??
                                  'Body is Empty'),
                      size: PSize.text16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 6, bottom: 6),
              child: Row(
                children: [
                  PText(
                    title: 'Headers :    ',
                    size: PSize.text16,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 0, bottom: 6, left: 10, right: 10),
              child: Row(
                children: [
                  PText(
                    title: '- Accept Language :    ',
                    size: PSize.text16,
                    fontWeight: FontWeight.w700,
                  ),
                  PText(
                    title: 'ar',
                    size: PSize.text16,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 6,
                left: 10,
                right: 10,
              ),
              child: Row(
                children: [
                  const PText(
                    title: '- Authorization :    ',
                    size: PSize.text16,
                    fontWeight: FontWeight.w700,
                  ),
                  Expanded(
                    child: SelectableText(
                      inspectorModel.authorization ?? '',
                      cursorColor: AppColors.primaryColor,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: PText(
                  //     title: inspectorModel.authorization ?? '',
                  //     size: PSize.text16,
                  //     fontWeight: FontWeight.w400,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
