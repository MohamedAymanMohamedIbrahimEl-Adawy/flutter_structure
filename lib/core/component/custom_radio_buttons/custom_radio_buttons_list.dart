import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';

import '../../data/constants/app_colors.dart';
import '../text/p_text.dart';

class RadioButtonsList extends StatefulWidget {
  final String? label;
  final bool isOptional;
  final List<dynamic> values;
  final String? initialSelection;
  final bool isVertical;
  final String keyTitle;
  final void Function(dynamic) onChange;
  final bool isEnabled;
  final Color? activeColor;
  final bool isFieldRequired;
  const RadioButtonsList({
    super.key,
    this.label,
    this.isOptional = false,
    required this.values,
    this.initialSelection,
    this.isVertical = true,
    required this.keyTitle,
    required this.onChange,
    this.isEnabled = true,
    this.activeColor,
    this.isFieldRequired = true,
  });

  @override
  State<RadioButtonsList> createState() => _RadioButtonsListState();
}

class _RadioButtonsListState extends State<RadioButtonsList> {
  String? _selectedValue;
  final List<Map<String, dynamic>> mapList = [];
  @override
  void initState() {
    _selectedValue = widget.initialSelection;

    // Convert List<Objects> to List<Map>
    mapList.addAll(widget.values.map((e) => e?.toMap()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label == null
            ? const SizedBox.shrink()
            : Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Row(
                children: [
                  PText(
                    title: widget.label?.tr() ?? '',
                    fontWeight: FontWeight.w500,
                    size: PSize.text16,
                  ),
                  widget.isFieldRequired
                      ? const PText(
                        title: ' *',
                        size: PSize.text14,
                        fontColor: AppColors.errorCode,
                        fontWeight: FontWeight.w600,
                      )
                      : const SizedBox.shrink(),
                  const SizedBox(width: 10),
                  widget.isOptional
                      ? Text(
                        "(optional)".tr(),
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(),
                      )
                      : Container(),
                ],
              ),
            ),
        widget.isVertical
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                mapList.length,
                (index) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio(
                      visualDensity: VisualDensity.comfortable,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: mapList[index][widget.keyTitle],
                      groupValue: _selectedValue,
                      activeColor: widget.activeColor ?? AppColors.primaryColor,
                      fillColor: WidgetStateProperty.resolveWith<Color>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.disabled)) {
                          return AppColors.contentColor;
                        } else if (states.contains(WidgetState.selected)) {
                          return AppColors.primaryColor;
                        }
                        return AppColors.contentColor;
                      }),
                      onChanged: (val) {
                        if (!widget.isEnabled) {
                          return;
                        }
                        setState(() {
                          _selectedValue = val;
                        });
                        widget.onChange(widget.values[index]);
                      },
                    ),
                    PText(
                      title:
                          mapList[index][widget.keyTitle]?.toString().tr() ??
                          '',
                      fontWeight: FontWeight.w400,
                      size: PSize.text14,
                    ),
                  ],
                ),
              ),
            )
            : Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              children: List.generate(
                mapList.length,
                (index) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio(
                      visualDensity: VisualDensity.standard,
                      value: mapList[index][widget.keyTitle],
                      groupValue: _selectedValue,
                      activeColor: widget.activeColor ?? AppColors.primaryColor,
                      onChanged: (val) {
                        if (!widget.isEnabled) {
                          return;
                        }
                        setState(() {
                          _selectedValue = val;
                        });
                        widget.onChange(widget.values[index]);
                      },
                    ),
                    PText(
                      title:
                          mapList[index][widget.keyTitle]?.toString().tr() ??
                          '',
                      size: PSize.text14,
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }
}

class RadioButtonsFromListOfMap extends StatefulWidget {
  final String? label;
  final bool isOptional;
  final List<Map<String, dynamic>> values;
  final String? initialSelection;
  final bool isVertical;
  final String keyTitle;
  final void Function(dynamic) onChange;
  final bool isEnabled;
  final Color? activeColor;
  final bool isFieldRequired;
  const RadioButtonsFromListOfMap({
    super.key,
    this.label,
    this.isOptional = false,
    required this.values,
    this.initialSelection,
    this.isVertical = true,
    required this.keyTitle,
    required this.onChange,
    this.isEnabled = true,
    this.activeColor,
    this.isFieldRequired = true,
  });

  @override
  State<RadioButtonsFromListOfMap> createState() =>
      _RadioButtonsFromListOfMapState();
}

class _RadioButtonsFromListOfMapState extends State<RadioButtonsFromListOfMap> {
  String? _selectedValue;
  @override
  void initState() {
    _selectedValue = widget.initialSelection;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label == null
            ? const SizedBox.shrink()
            : Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Row(
                children: [
                  PText(
                    title: widget.label?.tr() ?? '',
                    fontWeight: FontWeight.w500,
                    size: PSize.text16,
                  ),
                  widget.isFieldRequired
                      ? const PText(
                        title: ' *',
                        size: PSize.text14,
                        fontColor: AppColors.errorCode,
                        fontWeight: FontWeight.w600,
                      )
                      : const SizedBox.shrink(),
                  const SizedBox(width: 10),
                  widget.isOptional
                      ? Text(
                        "(optional)".tr(),
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(),
                      )
                      : Container(),
                ],
              ),
            ),
        widget.isVertical
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                widget.values.length,
                (index) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio(
                      visualDensity: VisualDensity.comfortable,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: widget.values[index][widget.keyTitle],
                      groupValue: _selectedValue,
                      activeColor: widget.activeColor ?? AppColors.primaryColor,
                      fillColor: WidgetStateProperty.resolveWith<Color>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.disabled)) {
                          return AppColors.contentColor;
                        } else if (states.contains(WidgetState.selected)) {
                          return AppColors.primaryColor;
                        }
                        return AppColors.contentColor;
                      }),
                      onChanged: (val) {
                        if (!widget.isEnabled) {
                          return;
                        }
                        setState(() {
                          _selectedValue = val;
                        });
                        widget.onChange(widget.values[index]);
                      },
                    ),
                    PText(
                      title:
                          widget.values[index][widget.keyTitle]
                              ?.toString()
                              .tr() ??
                          '',
                      fontWeight: FontWeight.w400,
                      size: PSize.text14,
                    ),
                  ],
                ),
              ),
            )
            : Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              children: List.generate(
                widget.values.length,
                (index) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio(
                      visualDensity: VisualDensity.standard,
                      value: widget.values[index][widget.keyTitle],
                      groupValue: _selectedValue,
                      activeColor: widget.activeColor ?? AppColors.primaryColor,
                      onChanged: (val) {
                        if (!widget.isEnabled) {
                          return;
                        }
                        setState(() {
                          _selectedValue = val;
                        });
                        widget.onChange(widget.values[index]);
                      },
                    ),
                    PText(
                      title:
                          widget.values[index][widget.keyTitle]
                              ?.toString()
                              .tr() ??
                          '',
                      size: PSize.text14,
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }
}
