import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_widget/markdown_widget.dart';

class MyMarkdown extends StatelessWidget {

  const MyMarkdown(
    this.data, {
    super.key,
  });

  /// Markdown 原始碼
  final String data;

  @override
  Widget build(BuildContext context) {
    return MarkdownWidget(
      data: data,
      selectable: true,
      shrinkWrap: true,
      config: MarkdownConfig(configs: [
        const H1Config(style: TextStyle(
          fontSize: 64,
          height: 77 / 64,
          fontWeight: FontWeight.bold,
        )),
        const H2Config(style: TextStyle(
          fontSize: 48,
          height: 58 / 48,
          fontWeight: FontWeight.bold,
        )),
        const H3Config(style: TextStyle(
          fontSize: 36,
          height: 44 / 36,
          fontWeight: FontWeight.bold,
        )),
        CodeConfig(style: GoogleFonts.ubuntuMono().copyWith(
          backgroundColor: const Color(0xffeff1f3),
        )),
        PreConfig(textStyle: GoogleFonts.ubuntuMono().copyWith(
          fontSize: 16,
        )),
      ]),
    );
  }
}