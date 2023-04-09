import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fucking_do_it/utils/palette.dart';
import 'package:fucking_do_it/utils/url_launcher.dart';

class MarkdownText extends StatelessWidget {
  final String text;
  final bool selectable;

  const MarkdownText({
    required this.text,
    required this.selectable,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(color: Palette.black);

    final MarkdownStyleSheet markdownStyle = MarkdownStyleSheet(
      a: textStyle.copyWith(color: Palette.primary),
      p: textStyle,
      h2: textStyle,
      h3: textStyle,
      h4: textStyle,
      h5: textStyle,
      h6: textStyle,
      horizontalRuleDecoration: BoxDecoration(
        border: Border.all(
          color: Palette.border,
          width: 0.5,
        ),
      ),
      checkbox: const TextStyle(
        fontSize: 18,
      ),
      em: textStyle,
      strong: textStyle.copyWith(fontWeight: FontWeight.bold),
      textAlign: WrapAlignment.start,
      h1Align: WrapAlignment.start,
      h2Align: WrapAlignment.start,
      h3Align: WrapAlignment.start,
      h4Align: WrapAlignment.start,
      h5Align: WrapAlignment.start,
      h6Align: WrapAlignment.start,
    );

    return MarkdownBody(
      selectable: selectable,
      onTapLink: _onTapLink,
      styleSheet: markdownStyle,
      data: text,
    );
  }

  void _onTapLink(String text, String? link, String other) {
    if (link != null) {
      UrlLauncher.open(link);
    }
  }
}
