import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_widget/markdown_widget.dart';

class MyMarkdown extends StatelessWidget {

  const MyMarkdown(
    this.data, {
    super.key,
    this.selectable = false,
  });

  /// Markdown 原始碼
  final String data;

  final bool selectable;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: MarkdownWidget(
        data: data,
        selectable: selectable,
        shrinkWrap: true,
        config: MarkdownConfig(configs: [
          const H1Config(style: TextStyle(
            fontSize: 48,
            // height: 77 / 64,
            fontWeight: FontWeight.bold,
          )),
          const H2Config(style: TextStyle(
            fontSize: 36,
            // height: 58 / 48,
            fontWeight: FontWeight.bold,
          )),
          const H3Config(style: TextStyle(
            fontSize: 24,
            // height: 44 / 36,
            fontWeight: FontWeight.bold,
          )),
          CodeConfig(style: GoogleFonts.ubuntuMono().copyWith(
            backgroundColor: const Color(0xffeff1f3),
          )),
          PreConfig(textStyle: GoogleFonts.ubuntuMono().copyWith(
            fontSize: 16,
          )),
        ]),
      ),
    );
  }
}