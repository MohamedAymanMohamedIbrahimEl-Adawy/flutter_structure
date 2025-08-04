import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/global/enums/global_enum.dart';
import '../../data/constants/app_colors.dart';
import '../text/p_text.dart';

class PDropDown extends StatefulWidget {
  final List<Map<String, dynamic>> options;
  final TextEditingController? controller;
  final Map<String, dynamic>? initialValue;
  final String? label;
  final String? dropdownLabel;
  final String? hintText;
  final Color? dropdownLabelColor;
  final bool? isOptional;
  final bool enableSearch;
  final double? width;
  final double? height;
  final bool isEnabled;
  final ValueChanged<Map<String, dynamic>?>? onChange;
  final FocusNode? focusNode;
  final bool translate;
  final Map<String, dynamic>? defaultResetOption;

  const PDropDown({
    super.key,
    required this.options,
    this.controller,
    this.initialValue,
    this.dropdownLabel,
    this.dropdownLabelColor,
    this.hintText,
    this.onChange,
    this.label,
    this.width,
    this.isEnabled = true,
    this.height,
    this.isOptional = false,
    this.enableSearch = false,
    this.focusNode,
    this.translate = false,
    this.defaultResetOption,
  });

  @override
  State<PDropDown> createState() => _MyCustomDropDownState();
}

class _MyCustomDropDownState extends State<PDropDown> {
  late final TextEditingController _controller;
  final List<Map<String, dynamic>> options = [];

  @override
  void initState() {
    if (widget.defaultResetOption != null) {
      options.add(widget.defaultResetOption!);
    }
    options.addAll(widget.options);
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!["label"];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              children: [
                PText(
                  title: widget.label!.tr(),
                  size: PSize.text14,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(width: 10),
                if (widget.isOptional!)
                  Text(
                    "(optional)".tr(),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
              ],
            ),
          ),
        Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonFormField<Map<String, dynamic>>(
              value: options.firstWhere(
                (option) => option["value"] == _controller.text,
                orElse: () => widget.initialValue ?? options.first,
              ),
              isExpanded: true,
              decoration: InputDecoration(
                hintText: widget.hintText?.tr() ?? 'Select'.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: AppColors.borderColor),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
              items:
                  options.map((option) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: option,
                      child: Text(
                        widget.translate
                            ? option["label"].toString().tr()
                            : option["label"].toString(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    );
                  }).toList(),
              onChanged:
                  widget.isEnabled
                      ? (value) {
                        setState(() {
                          _controller.text = value?["label"];
                        });
                        if (widget.onChange != null) {
                          widget.onChange!(value);
                        }
                      }
                      : null,
            ),
          ),
        ),
      ],
    );
  }
}
