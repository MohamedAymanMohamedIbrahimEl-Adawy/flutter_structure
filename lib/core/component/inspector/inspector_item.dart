import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/component/inspector/inspector_details_screen.dart';
import 'package:cleanarchitecture/core/component/inspector/inspector_model.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/extensions/navigator_extensions.dart';

class InspectorItem extends StatelessWidget {
  const InspectorItem({super.key, this.isFailed = false, required this.item});
  final bool isFailed;
  final InspectorModel item;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushWidget(InspectorDetailsScreen(inspectorModel: item), '');
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: isFailed ? Colors.red : Colors.green,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: PText(
                    title:
                        isFailed
                            ? 'Fail ${item.statusCode}'
                            : 'OK ${item.statusCode}',
                    size: PSize.text16,
                    fontColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 40),
                // Expanded(
                //   child: PText(title: item.uri?.path??'',
                //     size: PSize.large,fontColor:Colors.black,),
                // ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: PText(
                      title: item.uri.toString(),
                      size: PSize.text16,
                      fontColor: isFailed ? Colors.red : Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 14,
                left: 8,
                right: 8,
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PText(
                    title: item.callingTime ?? '',
                    size: PSize.text16,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  PText(
                    title: item.startTime ?? '',
                    size: PSize.text16,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.black),
          ],
        ),
      ),
    );
  }
}
