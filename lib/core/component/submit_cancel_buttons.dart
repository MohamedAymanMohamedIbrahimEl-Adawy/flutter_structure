import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleanarchitecture/core/component/button/p_button.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/global/state/base_state.dart';
import 'package:go_router/go_router.dart';

class SubmitCancelButtons<B extends BlocBase<S>, S> extends StatelessWidget {
  final Function()? onSubmitTap;
  final Function()? onCancelTap;
  final EdgeInsetsGeometry? padding;
  const SubmitCancelButtons({
    super.key,
    this.onCancelTap,
    this.onSubmitTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: PButton<B, S>(
              size: PSize.text16,
              title: 'submit'.tr(),
              onPressed: onSubmitTap,
              isButtonAlwaysExist: false,
              isFirstButton: true,
            ),
          ),
          const SizedBox(width: 20),
          BlocBuilder<B, S>(
            builder: (_, state) {
              return Expanded(
                child: IgnorePointer(
                  ignoring: state is ButtonLoadingState,
                  child: PButton(
                    size: PSize.text16,
                    title: 'cancel'.tr(),
                    onPressed:
                        onCancelTap ??
                        () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context.pop();
                        },
                    fillColor: AppColors.errorCode,
                    hasBloc: false,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
