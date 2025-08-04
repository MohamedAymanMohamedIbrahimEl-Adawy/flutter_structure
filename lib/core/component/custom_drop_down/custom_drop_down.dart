import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';
import '../../data/constants/app_colors.dart';
import '../../global/enums/global_enum.dart';
import '../../services/localization/app_localization.dart';
import '../text/p_text.dart';
import 'package:collection/collection.dart';

class MyCustomDropDown extends StatefulWidget {
  final List<String> options;
  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final String? dropdownLabel;
  final String? hintText;
  final Color? dropdownLabelColor;
  final bool? isOptional;
  final bool enableSearch;
  final double? width;
  final double? height;
  final bool isEnabled;
  final ValueChanged<dynamic>? onChange;
  final FocusNode? focusNode;
  final bool translate;
  final String? defaulResetLabel;
  final bool isFieldRequired;
  const MyCustomDropDown({
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
    this.defaulResetLabel,
    this.isFieldRequired = false,
  });

  @override
  State<MyCustomDropDown> createState() => _MyCustomDropDownState();
}

class _MyCustomDropDownState extends State<MyCustomDropDown> {
  late final TextEditingController _controller;
  final List<String> options = [];
  @override
  void initState() {
    if (widget.defaulResetLabel != null) {
      options.add(widget.defaulResetLabel!);
    }
    options.addAll(widget.options);
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.initialValue ?? _controller.text;
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                children: [
                  PText(
                    title: widget.label?.tr() ?? '',
                    size: PSize.text14,
                    fontWeight: FontWeight.w600,
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
                  widget.isOptional!
                      ? Text(
                        "(optional)".tr(),
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(),
                      )
                      : Container(),
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
              color:
                  isDark
                      ? AppColors.darkFieldBackgroundColor
                      : AppColors.whiteColor, // Background color
              borderRadius: BorderRadius.circular(4), // Corner radius
            ),
            child: DropdownMenu(
              requestFocusOnTap: widget.enableSearch,
              focusNode: widget.focusNode,
              enabled: options.isEmpty ? false : widget.isEnabled,
              controller: widget.controller,
              label:
                  widget.dropdownLabel != null
                      ? Text(
                        widget.dropdownLabel?.tr() ?? '',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color:
                              widget.dropdownLabelColor ??
                              AppColors.contentColor,
                        ),
                      )
                      : const SizedBox.shrink(),
              width: widget.width ?? 150,
              menuHeight: 300, //Add Fixed height
              onSelected: (value) {
                FocusManager.instance.primaryFocus?.unfocus();
                if (widget.onChange != null) {
                  widget.onChange!(value);
                }
                setState(() {
                  _controller.text = value as String;
                });
              },
              enableSearch: widget.enableSearch,
              // initialSelection: selectedValue?,
              textStyle: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(fontSize: 12),
              trailingIcon: const Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 20,
                color: AppColors.contentColor,
              ),

              leadingIcon: null, // const Icon(Icons.search),
              selectedTrailingIcon: const Icon(
                Icons.keyboard_arrow_up_outlined,
                size: 20,
                color: AppColors.contentColor,
              ),
              menuStyle: MenuStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(
                  isDark
                      ? AppColors.darkFieldBackgroundColor
                      : AppColors.whiteColor,
                ),
                alignment:
                    AppLocalization.isArabic
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
              ),
              // hintText: widget.hintText?.tr() ?? 'select'.tr(),
              inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                constraints: BoxConstraints.tight(
                  Size.fromHeight(widget.height ?? 48),
                ),
                hintStyle: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppColors.contentColor),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.focusedBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.focusedBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color:
                        isDark
                            ? AppColors.darkBorderColor
                            : AppColors.borderColor,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        isDark
                            ? AppColors.darkBorderColor
                            : AppColors.borderColor,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
              ),
              // inputDecorationTheme: const InputDecorationTheme(
              //   filled: true,
              //   contentPadding: EdgeInsets.symmetric(vertical: 5.0),
              // ),
              dropdownMenuEntries: List.generate(
                options.length,
                (index) => DropdownMenuEntry(
                  value: options[index],
                  label:
                      widget.translate ? options[index].tr() : options[index],
                  // leadingIcon: Icon(
                  //   Icons.check,
                  //   color: AppColors.primaryColor,
                  // ),
                  trailingIcon:
                      options[index] == _controller.text
                          ? Icon(
                            Icons.check,
                            color:
                                isDark
                                    ? AppColors.whiteColor
                                    : AppColors.primaryColor,
                            size: 14,
                          )
                          : null,

                  style: MenuItemButton.styleFrom(
                    // foregroundColor: AppColors.primaryColor50,
                    // padding: EdgeInsets.only(left: 1),
                    foregroundColor:
                        options[index] == _controller.text
                            ? isDark
                                ? AppColors.whiteColor
                                : AppColors.primaryColor
                            : AppColors.contentColor,
                    backgroundColor:
                        isDark
                            ? AppColors.darkFieldBackgroundColor
                            : AppColors.whiteColor,
                    alignment: Alignment.center,
                    textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight:
                          options[index] == _controller.text
                              ? FontWeight.w600
                              : FontWeight.w400,
                      color:
                          options[index] == _controller.text
                              ? AppColors.primaryColor
                              : AppColors.contentColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyCustomDropDownMapOptions extends StatefulWidget {
  final List<Map<String, dynamic>> options;
  final String keyTitle;
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
  final ValueChanged<dynamic>? onChange;
  final FocusNode? focusNode;
  final bool translate;
  final String? defaulResetLabel;
  final bool isFieldRequired;
  final bool enableFilter;
  const MyCustomDropDownMapOptions({
    super.key,
    required this.options,
    required this.keyTitle,
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
    this.defaulResetLabel,
    this.isFieldRequired = false,
    this.enableFilter = false,
  });

  @override
  State<MyCustomDropDownMapOptions> createState() =>
      _MyCustomDropDownMapOptionsState();
}

class _MyCustomDropDownMapOptionsState
    extends State<MyCustomDropDownMapOptions> {
  late final TextEditingController _controller;
  Map<String, dynamic>? selectedValue;
  @override
  void initState() {
    if (widget.defaulResetLabel != null) {
      widget.options.insert(0, {widget.keyTitle: widget.defaulResetLabel!});
    }

    _controller = widget.controller ?? TextEditingController();
    selectedValue = widget.initialValue;
    if (selectedValue != null) {
      _controller.text = selectedValue![widget.keyTitle] ?? '';
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyCustomDropDownMapOptions oldWidget) {
    if (!areListsEqualDeep(widget.options, oldWidget.options)) {
      selectedValue = null;
      _controller.clear();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label == null
            ? const SizedBox.shrink()
            : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                children: [
                  PText(
                    title: widget.label?.tr() ?? '',
                    size: PSize.text14,
                    fontWeight: FontWeight.w600,
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
                  widget.isOptional!
                      ? Text(
                        "(optional)".tr(),
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(),
                      )
                      : Container(),
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
              color:
                  isDark
                      ? AppColors.darkFieldBackgroundColor
                      : AppColors.whiteColor, // Background color
              borderRadius: BorderRadius.circular(4), // Corner radius
            ),
            child: DropdownMenu(
              requestFocusOnTap: widget.enableSearch,
              enableFilter: widget.enableFilter,
              focusNode: widget.focusNode,
              enabled: widget.options.isEmpty ? false : widget.isEnabled,
              controller: _controller,
              initialSelection: widget.initialValue,
              label:
                  widget.dropdownLabel != null
                      ? Text(
                        widget.dropdownLabel?.tr() ?? '',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color:
                              widget.dropdownLabelColor ??
                              AppColors.contentColor,
                        ),
                      )
                      : null,
              width: widget.width ?? MediaQuery.sizeOf(context).width - 32,
              menuHeight: 300, //Add Fixed height
              onSelected: (value) {
                FocusManager.instance.primaryFocus?.unfocus();

                selectedValue = value;
                _controller.text = selectedValue?[widget.keyTitle];

                if (widget.onChange != null) {
                  widget.onChange!(value);
                }
              },
              enableSearch: widget.enableSearch,

              textStyle: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(fontSize: 12),
              trailingIcon: const Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 20,
                color: AppColors.contentColor,
              ),

              leadingIcon: null, // const Icon(Icons.search),
              selectedTrailingIcon: const Icon(
                Icons.keyboard_arrow_up_outlined,
                size: 20,
                color: AppColors.contentColor,
              ),
              menuStyle: MenuStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(
                  isDark
                      ? AppColors.darkFieldBackgroundColor
                      : AppColors.whiteColor,
                ),
                alignment:
                    AppLocalization.isArabic
                        ? Alignment.bottomRight
                        : Alignment.bottomLeft,
              ),
              hintText: widget.hintText?.tr() ?? 'select'.tr(),
              inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                constraints: BoxConstraints.tight(
                  Size.fromHeight(widget.height ?? 48),
                ),
                hintStyle: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppColors.contentColor),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.focusedBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.focusedBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color:
                        isDark
                            ? AppColors.darkBorderColor
                            : AppColors.borderColor,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        isDark
                            ? AppColors.darkBorderColor
                            : AppColors.borderColor,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
              ),
              dropdownMenuEntries: List.generate(
                widget.options.length,
                (index) => DropdownMenuEntry<Map<String, dynamic>>(
                  value: widget.options[index],

                  label:
                      widget.translate
                          ? widget.options[index][widget.keyTitle].tr()
                          : widget.options[index][widget.keyTitle],
                  // leadingIcon: Icon(
                  //   Icons.check,
                  //   color: AppColors.primaryColor,
                  // ),
                  trailingIcon:
                      widget.options[index][widget.keyTitle] ==
                              selectedValue?[widget.keyTitle]
                          ? Icon(
                            Icons.check,
                            color:
                                isDark
                                    ? AppColors.whiteColor
                                    : AppColors.primaryColor,
                            size: 14,
                          )
                          : null,
                  style: MenuItemButton.styleFrom(
                    foregroundColor:
                        widget.options[index][widget.keyTitle] ==
                                selectedValue?[widget.keyTitle]
                            ? isDark
                                ? AppColors.whiteColor
                                : AppColors.primaryColor
                            : AppColors.contentColor,
                    backgroundColor:
                        isDark
                            ? AppColors.darkFieldBackgroundColor
                            : AppColors.whiteColor,
                    alignment: Alignment.center,
                    textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight:
                          widget.options[index][widget.keyTitle] ==
                                  selectedValue?[widget.keyTitle]
                              ? FontWeight.w600
                              : FontWeight.w400,
                      color:
                          widget.options[index][widget.keyTitle] ==
                                  selectedValue?[widget.keyTitle]
                              ? AppColors.primaryColor
                              : AppColors.contentColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

bool areListsEqualDeep(
  List<Map<String, dynamic>> list1,
  List<Map<String, dynamic>> list2,
) {
  return const DeepCollectionEquality().equals(list1, list2);
}
