import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class YoutubePlayer extends StatefulWidget {
  const YoutubePlayer({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.callback,
  });

  final String url;
  final double? width;
  final double? height;
  final void Function(Size size)? callback;

  @override
  State<YoutubePlayer> createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayer> {
  final _webviewController = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams());

  String _vid = "";
  double _width = 560;
  double _height = 315;

  @override
  void initState() {
    super.initState();

    if (widget.width != null && widget.height != null) {
      _width = widget.width!;
      _height = widget.height!;
    } else if (widget.width != null) {
      _width = widget.width!;
      // _height = (_width - 25) / 16 * 9 + 16;
      _height = _width / 16 * 9;
    } else if (widget.height != null) {
      _height = widget.height!;
      // _width = (_height - 16) / 9 * 16 + 25;
      _width = _height / 9 * 16;
    }

    _vid = _parseVid(widget.url);

    _webviewController.loadHtmlString(
        '<iframe width="${_width}" height="${_height}" src="https://www.youtube.com/embed/$_vid" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.callback != null) {
        widget.callback!.call(Size(_width, _height));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_vid == "") {
      return SizedBox(
          width: _width, height: _height, child: const Placeholder());
    }
    return SizedBox(
      width: _width,
      height: _height,
      child: PlatformWebViewWidget(
        PlatformWebViewWidgetCreationParams(controller: _webviewController),
      ).build(context),
    );
  }

  String _parseVid(String url) {
    final match = RegExp(
            r"((?<=youtube\.com\/watch\?v=)|(?<=youtu\.be\/)|(?<=youtube\.com\/embed\/))(.+)(?=\/*)")
        .stringMatch(url);
    return match ?? "";
  }
}
