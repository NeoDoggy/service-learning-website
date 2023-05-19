import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/providers/floating_window_provider.dart';
import 'package:service_learning_website/widgets/app_bar_g.dart';
import 'package:service_learning_website/widgets/footer.dart';

class PageSkeleton extends StatelessWidget {
  const PageSkeleton({
    super.key,
    required this.body,
    this.navigationBar,
    this.footer,
    this.bottomSheet,
    this.isPadding = true,
  });

  final Widget? navigationBar;
  final Widget body;
  final Widget? footer;
  final Widget? bottomSheet;
  final bool isPadding;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 800) {
      return const Scaffold(
          body: Center(child: Text("裝置寬度過小，目前暫不支援手機瀏覽，敬請見諒")));
    }

    final windowHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body:
          Consumer<FloatingWindowProvider>(builder: (context, provider, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) =>
                  [navigationBar ?? const AppBarG()],
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // navigationBar ?? const NavBar(),
                    ConstrainedBox(
                      constraints: BoxConstraints(minHeight: windowHeight),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: isPadding
                              ? MediaQuery.of(context).size.width / 1440 * 150
                              : 0,
                          right: isPadding
                              ? MediaQuery.of(context).size.width / 1440 * 150
                              : 0,
                          top: 60,
                          bottom: 100,
                        ),
                        child: body,
                      ),
                    ),
                    footer ?? const Footer(),
                  ],
                ),
              ),
            ),
            if (provider.child != null)
              GestureDetector(
                onTap: () => provider.child = null,
                child: MouseRegion(
                  cursor: SystemMouseCursors.contextMenu,
                  child: Container(color: Colors.black45),
                ),
              ),
            if (provider.child != null) provider.child!,
          ],
        );
      }),
      // bottomSheet: bottomSheet,
    );
  }
}
