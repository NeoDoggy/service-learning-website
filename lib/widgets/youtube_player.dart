import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/providers/floating_window_provider.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class YoutubePlayer extends StatefulWidget {
  const YoutubePlayer({
    super.key,
    required this.url,
    this.width,
    this.height,
  });

  final String url;
  final double? width;
  final double? height;

  @override
  State<YoutubePlayer> createState() => _YoutubePlayerState();

  static double getHeightFromWidth(double width) {
    return (width - 25) / 16 * 9 + 16;
  }

  static double getWidthFromHeight(double height) {
    return (height - 16) / 9 * 16 + 25;
  }
}

class _YoutubePlayerState extends State<YoutubePlayer> {
  final _webviewController = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams());

  @override
  Widget build(BuildContext context) {
    final vid = _parseVid(widget.url);

    return LayoutBuilder(builder: (context, constraint) {
      if (vid == "" || context.watch<FloatingWindowProvider>().child != null) {
        return Center(child: Text("沒有影片 :("));
      }

      _webviewController.loadHtmlString(
          '<iframe width="${constraint.maxWidth - 25}" height="${constraint.maxHeight - 16}" src="https://www.youtube.com/embed/$vid?rel=0" title="YouTube video player" frameborder="0" allow="fullscreen; accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>');
      // '<iframe src="https://drive.google.com/file/d/1A8UX7vipYEhFPHfvUSSueKno1pr7pnzK/preview" width="${constraint.maxWidth - 30}" height="${constraint.maxHeight - 20}" allow="autoplay" allowfullscreen></iframe>');

      return PlatformWebViewWidget(PlatformWebViewWidgetCreationParams(
              controller: _webviewController))
          .build(context);
    });
  }

  String _parseVid(String url) {
    final match = RegExp(
            r"((?<=youtube\.com\/watch\?v=)|(?<=youtu\.be\/)|(?<=youtube\.com\/embed\/))(.+)(?=\/*)")
        .stringMatch(url);
    return match ?? "";
  }
}
