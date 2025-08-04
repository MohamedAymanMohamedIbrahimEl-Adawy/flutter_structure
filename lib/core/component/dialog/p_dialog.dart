import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleanarchitecture/core/component/button/p_button.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';
import 'package:cleanarchitecture/core/global/state/base_state.dart';
import 'package:cleanarchitecture/core/services/localization/app_localization.dart';
import 'package:cleanarchitecture/features/more/presentation/bloc/logout_bloc.dart';
import '../../data/constants/app_colors.dart';

class PDialog extends StatelessWidget {
  final String title;
  final String description;
  final Widget? icon;
  final Widget? customContent;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String confirmText;
  final String cancelText;
  final bool showCancelButton;
  final Color confirmButtonColor;
  final BuildContext screenContext;
  final Color cancelButtonColor;
  final LogoutBloc logoutBloc;

  const PDialog({
    super.key,
    required this.title,
    required this.logoutBloc,
    required this.description,
    required this.screenContext,
    this.icon,
    this.customContent,
    this.onConfirm,
    this.onCancel,
    this.confirmText = "نعم",
    this.cancelText = "إلغاء",
    this.showCancelButton = true,
    this.confirmButtonColor = Colors.blue,
    this.cancelButtonColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: _buildDialogContent(context),
      ),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Directionality(
      textDirection:
          AppLocalization.isArabic ? TextDirection.ltr : TextDirection.rtl,
      child: StatefulBuilder(
        builder: (context, setState) {
          return BlocProvider(
            create: (BuildContext context) => logoutBloc,
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 70.0),
              decoration: BoxDecoration(
                color:
                    isDark ? AppColors.darkFieldBackgroundColor : Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min, // To make the dialog compact
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: AppColors.contentColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  customContent ?? Container(), // Insert custom widget if any
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (showCancelButton)
                        Expanded(
                          child: SizedBox(
                            child: TextButton(
                              onPressed:
                                  onCancel ?? () => Navigator.of(context).pop(),
                              style: TextButton.styleFrom(
                                backgroundColor: cancelButtonColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                              ),
                              child: Text(
                                cancelText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(width: 8.0),
                      BlocListener<LogoutBloc, BaseState>(
                        listener: (context, state) async {},
                        child: Expanded(
                          child: SizedBox(
                            height: 40,
                            child: PButton<LogoutBloc, BaseState>(
                              isButtonAlwaysExist: false,
                              isFirstButton: true,
                              isFitWidth: true,
                              onPressed: () {
                                setState(() {});
                                logoutBloc.add(ActionLogoutEvent(context));
                              },
                              title: confirmText,
                              size: PSize.text16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
