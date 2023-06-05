import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/problems_provider.dart';

class ProblemsPage extends StatelessWidget {
  const ProblemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageSkeleton(
        body: Consumer<ProblemsProvider>(
      builder: (context, value, child) {
        return Column();
      }
    ));
  }
}
