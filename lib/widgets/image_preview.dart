import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/providers/floating_window_provider.dart';

class ImagePreview extends StatefulWidget {
  const ImagePreview({
    super.key,
    required this.image,
    this.enable = true,
    this.width,
    this.height,
    this.sideWidget,
    this.onTap,
  });

  final Uint8List image;
  final bool enable;
  final double? width;
  final double? height;
  final Widget? sideWidget;
  final void Function()? onTap;

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) widget.onTap!.call();
        if (widget.enable) {
          context.read<FloatingWindowProvider>().child = Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.memory(widget.image,
                    width: MediaQuery.of(context).size.width * 0.6,
                    fit: BoxFit.fitWidth),
                if (widget.sideWidget != null) const SizedBox(width: 20),
                if (widget.sideWidget != null) widget.sideWidget!,
              ],
            ),
          );
        }
      },
      child: MouseRegion(
        onEnter: (event) => setState(() => _isHovered = true),
        onExit: (event) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 4,
              color: _isHovered ? Colors.black26 : Colors.transparent,
            ),
          ),
          child: Image.memory(
            widget.image,
            fit: BoxFit.cover,
            width: widget.width,
            height: widget.height,
          ),
        ),
      ),
    );
  }
}
