import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/inspector/inspector_model.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';

class OverviewWidget extends StatelessWidget {
  final InspectorModel inspectorModel;
  const OverviewWidget({super.key, required this.inspectorModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 6),
            child: Row(
              children: [
                const PText(
                  title: 'Method : ',
                  size: PSize.text16,
                  fontWeight: FontWeight.w700,
                ),
                PText(
                  title: inspectorModel.method ?? '',
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
                  title: 'Server :    ',
                  size: PSize.text16,
                  fontWeight: FontWeight.w700,
                ),
                PText(
                  title: inspectorModel.baseUrl ?? '',
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
                  title: 'Endpoint :    ',
                  size: PSize.text16,
                  fontWeight: FontWeight.w700,
                ),
                Expanded(
                  child: PText(
                    title: inspectorModel.uri?.path ?? '',
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
                  title: 'Finished :    ',
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
            padding: const EdgeInsets.only(top: 6, bottom: 6),
            child: Row(
              children: [
                const PText(
                  title: 'Duration :    ',
                  size: PSize.text16,
                  fontWeight: FontWeight.w700,
                ),
                PText(
                  title: inspectorModel.callingTime ?? '',
                  size: PSize.text16,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 6, bottom: 6),
            child: Row(
              children: [
                PText(
                  title: 'Client :    ',
                  size: PSize.text16,
                  fontWeight: FontWeight.w700,
                ),
                PText(
                  title: 'Dio',
                  size: PSize.text16,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
