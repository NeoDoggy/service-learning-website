import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 使 Icon 可以轉換成圖片
class IconImage extends ImageProvider<IconImage> {

  final IconData icon;
  final double scale;
  final int size;
  final Color color;
  final Color background;

  IconImage({
    required this.icon,
    this.scale = 1.0,
    this.size = 64,
    this.color = Colors.white,
    this.background = Colors.transparent
  });

  @override
  Future<IconImage> obtainKey(ImageConfiguration configuration)
    => SynchronousFuture<IconImage>(this);

  @override
  ImageStreamCompleter loadBuffer(IconImage key, DecoderBufferCallback decode)
    => OneFrameImageStreamCompleter(_loadAsync(key));

  Future<ImageInfo> _loadAsync(IconImage key) async {
    assert (key == this);

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.scale(scale, scale);
    canvas.drawColor(background, BlendMode.color);
    final textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: size.toDouble(),
        fontFamily: icon.fontFamily,
        color: color,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset.zero);
    final image = await recorder.endRecording().toImage(size, size);
    return ImageInfo(image: image, scale: scale);
  }

  @override
  bool operator==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final IconImage typedOther = other;
    return icon == typedOther.icon && scale == typedOther.scale && size == typedOther.size && color == typedOther.color;
  }

  @override
  int get hashCode => Object.hash(icon.hashCode, scale, size, color);

  @override
  String toString() => '$runtimeType(${describeIdentity(icon)}, scale: $scale, size: $size, color: $color)';
}