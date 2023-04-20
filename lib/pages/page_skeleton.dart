import 'package:flutter/material.dart';

class PageSkeleton extends StatelessWidget {
  const PageSkeleton({
    super.key,
    this.body,
    this.navigationBar,
    this.footer,
    this.bottomSheet,
  });

  final Widget? navigationBar;
  final Widget? body;
  final Widget? footer;
  final Widget? bottomSheet;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (navigationBar != null)
              navigationBar!,
            if (body != null)
              body!,
            if (footer != null)
              footer!,
          ],
        ),
      ),
      bottomSheet: bottomSheet,
    );
  }
}