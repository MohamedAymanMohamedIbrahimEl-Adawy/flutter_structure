import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import 'package:cleanarchitecture/core/services/localization/app_localization.dart';

import '../../data/assets_helper/app_svg_icon.dart';
import '../text/p_text.dart';

class PTextField extends StatefulWidget {
  final String? hintText, errorText, obscuringCharacter;
  final String? initialText;
  final String? labelAbove;
  final bool isFieldRequired;
  final PSize? labelAboveFontSize;
  final FontWeight? labelAboveFontWeight;
  final Color? textColor,
      labelAboveColor,
      hintColor,
      fillColor,
      borderColor,
      disabledBorderColor,
      focusedColor,
      errorBorderColor;
  final bool isObscured;
  final bool isPassword;
  final double? borderRadius;
  final TextEditingController? controller;
  final int? maxLines;
  final FontWeight? fontWeight;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final bool? isDense;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final PSize size;
  final Widget? prefixIcon;
  final InputBorder? focusInputBorder;
  final InputBorder? enabledInputBorder;
  final EdgeInsetsGeometry? contentPadding;
  final GlobalKey<FormState>? formKey;
  final void Function(String? value) feedback;
  final String? Function(String? value) validator;
  final bool isHasSpecialCharcters;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final bool isOptional;
  const PTextField({
    super.key,
    this.labelAbove,
    this.labelAboveFontSize,
    this.labelAboveFontWeight,
    required this.hintText,
    this.isFieldRequired = false,
    this.inputFormatters,
    this.textInputType = TextInputType.text,
    this.textColor,
    this.textInputAction,
    this.labelAboveColor,
    this.focusInputBorder,
    this.contentPadding,
    this.enabledInputBorder,
    required this.feedback,
    this.fillColor,
    this.focusedColor,
    this.borderColor,
    this.disabledBorderColor,
    this.errorBorderColor,
    this.hintColor,
    this.isObscured = false,
    this.size = PSize.text16,
    this.errorText,
    this.controller,
    this.isPassword = false,
    this.enabled,
    this.obscuringCharacter = '*',
    this.fontWeight,
    this.isDense = false,
    required this.validator,
    this.formKey,
    this.borderRadius,
    this.maxLines,
    this.initialText,
    this.prefixIcon,
    this.isHasSpecialCharcters = false,
    this.currentFocus,
    this.nextFocus,
    this.isOptional = false,
  });

  @override
  State<PTextField> createState() => _PTextFieldState();
}

class _PTextFieldState extends State<PTextField> {
  TextEditingController? controller;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    controller ??= TextEditingController()..text = widget.initialText ?? '';
    super.initState();
  }

  // late  bool isObscured = widget.isObscured;
  late bool isObscured = widget.isPassword;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelAbove != null
            ? Row(
              children: [
                PText(
                  title: widget.labelAbove!.tr(),
                  size: widget.labelAboveFontSize ?? PSize.text14,
                  fontColor: widget.labelAboveColor,
                  fontWeight: widget.labelAboveFontWeight ?? FontWeight.w600,
                ),
                widget.isFieldRequired
                    ? PText(
                      title: ' *',
                      size: widget.labelAboveFontSize ?? PSize.text14,
                      fontColor: AppColors.errorCode,
                      fontWeight:
                          widget.labelAboveFontWeight ?? FontWeight.w600,
                    )
                    : const SizedBox.shrink(),
                const SizedBox(width: 8),
                widget.isOptional
                    ? Text(
                      "(optional)".tr(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(),
                    )
                    : Container(),
              ],
            )
            : const SizedBox.shrink(),
        widget.labelAbove != null
            ? const SizedBox(height: 8)
            : const SizedBox.shrink(),
        Form(
          key: widget.formKey,
          child: TextFormField(
            textAlign:
                AppLocalization.isArabic ? TextAlign.right : TextAlign.left,
            enabled: widget.enabled,
            focusNode: widget.currentFocus,
            textInputAction:
                widget.textInputAction ??
                (widget.nextFocus != null
                    ? TextInputAction.next
                    : TextInputAction.done),
            scrollController: scrollController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: widget.controller ?? controller,
            obscureText: isObscured,
            cursorColor: AppColors.primaryColor,
            keyboardType: widget.textInputType ?? TextInputType.text,
            inputFormatters: widget.inputFormatters ?? [],
            obscuringCharacter: widget.obscuringCharacter ?? '*',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: widget.textColor),
            maxLines: !isObscured ? widget.maxLines : 1,
            onChanged: (value) {
              widget.feedback(value);
            },
            validator: widget.validator,
            textDirection:
                (widget.isHasSpecialCharcters &&
                        context.locale.languageCode == 'ar')
                    ? TextDirection.ltr
                    : context.locale.languageCode == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
            decoration: InputDecoration(
              errorStyle: const TextStyle(color: AppColors.errorBorderColor),
              isDense: widget.isDense ?? false,
              // constraints: const BoxConstraints(maxHeight: 44),
              alignLabelWithHint: true,
              hintText: widget.hintText?.tr(),
              contentPadding:
                  widget.contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              suffixIcon:
                  widget.isPassword
                      ? IconButton(
                        icon:
                            isObscured
                                ? SvgPicture.asset(AppSvgIcons.eyeColose)
                                : SvgPicture.asset(AppSvgIcons.eyeOpen),
                        onPressed: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                      )
                      : null,
              // prefixIcon: (widget.isHasSpecialCharcters &&
              //         context.locale.languageCode == 'ar' &&
              //         widget.isPassword)
              //     ? IconButton(
              //         icon: isObscured
              //             ? SvgPicture.asset(AppSvgIcons.eyeColose)
              //             : SvgPicture.asset(AppSvgIcons.eyeOpen),
              //         onPressed: () {
              //           setState(() {
              //             isObscured = !isObscured;
              //           });
              //         })
              //     : widget.prefixIcon,
              filled: true,
              fillColor: widget.fillColor,
              hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: widget.hintColor ?? AppColors.contentColor,
              ),
              focusedBorder:
                  widget.focusInputBorder ??
                  OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          widget.focusedColor ?? AppColors.focusedBorderColor,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius ?? 4),
                    ),
                  ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.errorBorderColor ?? AppColors.errorBorderColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 4),
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.errorBorderColor ?? AppColors.errorBorderColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 4),
                ),
              ),
              enabledBorder:
                  widget.enabledInputBorder ??
                  OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          widget.borderColor ??
                          Theme.of(
                            context,
                          ).inputDecorationTheme.border!.borderSide.color,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius ?? 4),
                    ),
                  ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.disabledBorderColor ?? AppColors.borderColor,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      widget.borderColor ??
                      Theme.of(
                        context,
                      ).inputDecorationTheme.border!.borderSide.color,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
