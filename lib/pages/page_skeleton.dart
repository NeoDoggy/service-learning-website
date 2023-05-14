import 'package:flutter/material.dart';
import 'package:service_learning_website/widgets/app_bar_g.dart';
import 'package:service_learning_website/widgets/footer.dart';

class PageSkeleton extends StatelessWidget {
  const PageSkeleton({
    super.key,
    required this.body,
    this.navigationBar,
    this.footer,
    this.bottomSheet,
  });

  final Widget? navigationBar;
  final Widget body;
  final Widget? footer;
  final Widget? bottomSheet;

  @override
  Widget build(BuildContext context) {
    final windowHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: NestedScrollView(
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
                    left: MediaQuery.of(context).size.width / 1440 * 150,
                    right: MediaQuery.of(context).size.width / 1440 * 150,
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
      bottomSheet: bottomSheet,
    );
  }
}
