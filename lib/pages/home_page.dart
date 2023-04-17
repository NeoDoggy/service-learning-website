import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service_learning_website/modules/my_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          child: const Text("Test Page"),
          onTap: () => context.go(MyRouter.test),
        )
      )
    );
  }
}