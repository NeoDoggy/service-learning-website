import 'package:go_router/go_router.dart';
import 'package:service_learning_website/pages/home_page.dart';
import 'package:service_learning_website/test/test_page.dart';

class MyRouter extends GoRouter {
  MyRouter() : super(
    routes: [
      GoRoute(
        path: MyRouter.root,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: MyRouter.test,
        builder: (context, state) => const TestPage(),
      ),
    ],
  );

  static const String root = "/";
  static const String test = "/test";
}