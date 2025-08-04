import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/services/base_network/interceptors/request_interceptor.dart';
import 'package:cleanarchitecture/core/component/button/p_button.dart';
import 'package:cleanarchitecture/core/component/button/p_floating_action_button.dart';
import 'package:cleanarchitecture/core/component/inspector/inspector_screen.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/data/constants/global_obj.dart';
import 'package:cleanarchitecture/core/extensions/navigator_extensions.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';

class InspectorFloationButton extends StatelessWidget {
  const InspectorFloationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PFloatingActionButton(
      child: SizedBox(
        width: 60,
        height: 60,
        child: ButtonWidget(
          elevation: 4,
          fillColor: AppColors.primaryColor,
          padding: const EdgeInsets.all(0),
          borderRadius: 40,
          onPressed: () {
            navigatorKey.currentState!.context.pushWidget(
              InspectorScreen(inspectorList: inspectList),
              '',
            );
            // navigatorKey.currentState!.context.pushWidget(const CalendarPackage(), '');
            // navigatorKey.currentState!.context.pushWidget(HijriCalendarExample(),'');
            // nirikshak.showNirikshak(navigatorKey.currentState!.context);
          },
          title: 'Inspect',
          size: PSize.text12,
        ),
      ),
    );
  }
}
