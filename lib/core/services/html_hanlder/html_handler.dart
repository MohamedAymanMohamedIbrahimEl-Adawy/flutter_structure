import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:cleanarchitecture/core/data/constants/app_colors.dart';

class HtmlHandler {
  Widget htmlToText({
    required String htmStr,
    int? maxLines,
    bool hasEllipsis = true,
    Color? color,
    FontWeight? fontWeight,
    bool underline = false,
  }) {
    return HtmlWidget(
      htmStr,
      textStyle: TextStyle(
        color: color ?? AppColors.titleColor.withValues(alpha: 0.5),
        overflow: hasEllipsis ? TextOverflow.ellipsis : null,
        fontWeight: fontWeight,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
      factoryBuilder: () => MaxLinesHtmlFactory(maxLines ?? 2),
      customStylesBuilder: (element) {
        return {
          if (hasEllipsis) 'overflow': 'hidden',
          if (hasEllipsis) 'text-overflow': 'ellipsis',
          'display': '-webkit-box',
          '-webkit-line-clamp': (maxLines ?? 2).toString(),
          '-webkit-box-orient': 'vertical',
        };
      },
    );
  }
}

class MaxLinesHtmlFactory extends WidgetFactory {
  final int maxLines;
  MaxLinesHtmlFactory(this.maxLines);

  @override
  Widget? buildText(
    BuildTree tree,
    InheritedProperties resolved,
    InlineSpan text,
  ) {
    return Text(
      text.toPlainText(),
      style: text.style,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
