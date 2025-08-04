import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/inspector/inspector_model.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';

class ErrorInspectorWidget extends StatelessWidget {
  final InspectorModel inspectorModel;
  const ErrorInspectorWidget({super.key, required this.inspectorModel});

  @override
  Widget build(BuildContext context) {
    return inspectorModel.statusCode == 200 || inspectorModel.statusCode == 201
        ? const Center(
          child: PText(title: 'Nothing to Preview Here', size: PSize.text16),
        )
        : SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PText(title: 'Error :    ', size: PSize.text16),
                    Expanded(
                      child: PText(
                        title: inspectorModel.error ?? '',
                        size: PSize.text16,
                        fontWeight: FontWeight.w300,
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

String formatJson(dynamic jsonObject) {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  return encoder.convert(jsonObject);
}
