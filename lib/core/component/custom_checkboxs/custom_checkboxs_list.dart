import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';
import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../text/p_text.dart';

class SingleCheckBox extends StatefulWidget {
  final bool isEnabled;
  final bool? initialSelection;
  final Color? activeColor;
  final Color? borderColor;
  final String? label;
  final bool checkBocEnabled;
  final void Function(bool)? onChange;
  const SingleCheckBox({
    super.key,
    this.isEnabled = true,
    this.initialSelection,
    this.onChange,
    this.checkBocEnabled = true,
    this.borderColor,
    this.label,
    this.activeColor,
  });

  @override
  State<SingleCheckBox> createState() => _SingleCheckBoxState();
}

class _SingleCheckBoxState extends State<SingleCheckBox> {
  bool value = false;
  @override
  void initState() {
    value = widget.initialSelection ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IgnorePointer(
          ignoring: !widget.checkBocEnabled,
          child: Checkbox(
            value: value,
            side: BorderSide(
              color:
                  widget.borderColor ??
                  (widget.activeColor ?? AppColors.contentColor),
              width: 2,
            ),
            activeColor: widget.activeColor ?? AppColors.contentColor,
            onChanged: (val) {
              setState(() {
                value = !value;
              });
              if (widget.onChange != null) {
                widget.onChange!(value);
              }
            },
          ),
        ),
        Text(
          widget.label ?? '',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.contentColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class CheckboxsList extends StatefulWidget {
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
  const CheckboxsList({
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
  State<CheckboxsList> createState() => _CheckboxsListState();
}

class _CheckboxsListState extends State<CheckboxsList> {
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
      children: [
        widget.label == null
            ? const SizedBox.shrink()
            : Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
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
                (index) => ListTileTheme(
                  horizontalTitleGap: 4.0,
                  child: CheckboxListTile(
                    dense: true, // Reduce vertical spacing
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    enabled: widget.isEnabled,
                    title: Text(
                      mapList[index][widget.keyTitle] ?? '',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.contentColor,
                        fontSize: 12,
                      ),
                    ),
                    value: _selectedValue == mapList[index][widget.keyTitle],
                    activeColor: widget.activeColor ?? AppColors.secondaryColor,
                    side: BorderSide(
                      color: widget.activeColor ?? AppColors.secondaryColor,
                      width: 2,
                    ),
                    onChanged: (val) {
                      if (!widget.isEnabled) {
                        return;
                      }
                      setState(() {
                        _selectedValue = mapList[index][widget.keyTitle];
                      });
                      widget.onChange(widget.values[index]);
                    },
                  ),
                ),
              ),
            )
            : Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              children: List.generate(
                mapList.length,
                (index) => SizedBox(
                  width: 130,
                  child: ListTileTheme(
                    horizontalTitleGap: 4.0,
                    child: CheckboxListTile(
                      dense: true, // Reduce vertical spacing
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      enabled: widget.isEnabled,
                      title: Text(
                        mapList[index][widget.keyTitle] ?? '',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.contentColor,
                          fontSize: 12,
                        ),
                      ),
                      value: _selectedValue == mapList[index][widget.keyTitle],
                      activeColor:
                          widget.activeColor ?? AppColors.secondaryColor,
                      side: BorderSide(
                        color: widget.activeColor ?? AppColors.secondaryColor,
                        width: 2,
                      ),
                      onChanged: (val) {
                        if (!widget.isEnabled) {
                          return;
                        }
                        setState(() {
                          _selectedValue = mapList[index][widget.keyTitle];
                        });
                        widget.onChange(widget.values[index]);
                      },
                    ),
                  ),
                ),
              ),
            ),
      ],
    );
  }
}

class CheckboxsListMultiSelect extends StatefulWidget {
  final String? label;
  final bool isOptional;
  final List<String> values;
  final List<String>? initialSelection;
  final bool isVertical;

  final void Function(List)? onChange;
  final bool isEnabled;
  final Color? activeColor;
  final bool isFieldRequired;
  const CheckboxsListMultiSelect({
    super.key,
    this.label,
    this.isOptional = false,
    required this.values,
    this.initialSelection,
    this.isVertical = true,
    this.onChange,
    this.isEnabled = true,
    this.activeColor,
    this.isFieldRequired = true,
  });

  @override
  State<CheckboxsListMultiSelect> createState() =>
      _CheckboxsListMultiSelectState();
}

class _CheckboxsListMultiSelectState extends State<CheckboxsListMultiSelect> {
  final List<String> _selectedValues = [];
  @override
  void initState() {
    if (widget.initialSelection != null) {
      _selectedValues.addAll(widget.initialSelection!);
    }
    // Convert List<Objects> to List<Map>
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.label == null
            ? const SizedBox.shrink()
            : Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  PText(
                    title: widget.label?.tr() ?? '',
                    fontWeight: FontWeight.w600,
                    size: PSize.text14,
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
                (index) => ListTileTheme(
                  horizontalTitleGap: 4.0,
                  child: CheckboxListTile(
                    dense: true, // Reduce vertical spacing
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    enabled: widget.isEnabled,
                    title: Text(
                      widget.values[index],
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color:
                            !_selectedValues.contains(widget.values[index])
                                ? AppColors.contentColor
                                : isDark
                                ? AppColors.whiteColor
                                : AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    value: _selectedValues.contains(widget.values[index]),
                    checkColor:
                        isDark ? AppColors.contentColor : AppColors.whiteColor,
                    activeColor: widget.activeColor ?? AppColors.primaryColor,
                    side: const BorderSide(
                      color: AppColors.contentColor,
                      width: 2,
                    ),
                    onChanged: (val) {
                      if (!widget.isEnabled) {
                        return;
                      }
                      setState(() {
                        if (val == true) {
                          _selectedValues.add(widget.values[index]);
                        } else {
                          _selectedValues.remove(widget.values[index]);
                        }
                      });
                      if (widget.onChange != null) {
                        widget.onChange!(_selectedValues);
                      }
                    },
                  ),
                ),
              ),
            )
            : Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              children: List.generate(
                widget.values.length,
                (index) => SizedBox(
                  width: 130,
                  child: ListTileTheme(
                    horizontalTitleGap: 4.0,
                    child: CheckboxListTile(
                      dense: true, // Reduce vertical spacing
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      enabled: widget.isEnabled,
                      title: Text(
                        widget.values[index],
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color:
                              !_selectedValues.contains(widget.values[index])
                                  ? AppColors.contentColor
                                  : isDark
                                  ? AppColors.whiteColor
                                  : AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      value: _selectedValues.contains(widget.values[index]),
                      checkColor:
                          isDark
                              ? AppColors.contentColor
                              : AppColors.whiteColor,
                      activeColor: widget.activeColor ?? AppColors.primaryColor,
                      side: const BorderSide(
                        color: AppColors.contentColor,
                        width: 2,
                      ),
                      onChanged: (val) {
                        if (!widget.isEnabled) {
                          return;
                        }
                        setState(() {
                          if (val == true) {
                            _selectedValues.add(widget.values[index]);
                          } else {
                            _selectedValues.remove(widget.values[index]);
                          }
                        });
                        if (widget.onChange != null) {
                          widget.onChange!(_selectedValues);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
      ],
    );
  }
}
