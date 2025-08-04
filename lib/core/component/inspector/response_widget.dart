import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/inspector/inspector_model.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';

class ResponseWidget extends StatelessWidget {
  final InspectorModel inspectorModel;
  const ResponseWidget({super.key, required this.inspectorModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 14,
              right: 14,
              top: 6,
              bottom: 6,
            ),
            child: Row(
              children: [
                const PText(
                  title: 'Received :    ',
                  size: PSize.text16,
                  fontWeight: FontWeight.w700,
                ),
                PText(
                  title: inspectorModel.endTime ?? '',
                  size: PSize.text16,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 14,
              right: 14,
              top: 6,
              bottom: 6,
            ),
            child: Row(
              children: [
                const PText(
                  title: 'Status :    ',
                  size: PSize.text16,
                  fontWeight: FontWeight.w700,
                ),
                PText(
                  title: inspectorModel.statusCode.toString(),
                  size: PSize.text16,
                  fontWeight: FontWeight.w400,
                  fontColor:
                      inspectorModel.statusCode == 200 ||
                              inspectorModel.statusCode == 201
                          ? Colors.green
                          : Colors.red,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 14, right: 14, top: 6, bottom: 6),
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
            padding: EdgeInsets.only(top: 0, bottom: 6, left: 24, right: 24),
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
              left: 14,
              right: 14,
              top: 6,
              bottom: 6,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PText(
                  title: 'Body :    ',
                  size: PSize.text16,
                  fontWeight: FontWeight.w700,
                ),
                Expanded(
                  child: PText(
                    title:
                        inspectorModel.responseBody != null
                            ? ((inspectorModel.responseBody is FormData)
                                ? parseFormData(inspectorModel.responseBody)
                                :
                                // beautifyLooseJson(inspectorModel.responseBody))
                                formatJson(inspectorModel.responseBody))
                            : '',
                    size: PSize.text16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
