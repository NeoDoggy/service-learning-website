import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:service_learning_website/pages/admin_page/admin_page.dart';
import 'package:service_learning_website/pages/course_editing_page/course_editing_page.dart';
import 'package:service_learning_website/pages/login_page.dart';
import 'package:service_learning_website/pages/welcome_page.dart';
import 'package:service_learning_website/test/test_page.dart';

class MyRouter extends GoRouter {
  MyRouter()
      : super(
          initialLocation: MyRouter.root,
          routes: [
            GoRoute(
              path: MyRouter.root,
              builder: (context, state) => const WelcomePage(),
            ),
            GoRoute(
              path: MyRouter.test,
              builder: (context, state) => TestPage(),
            ),
            GoRoute(
              path: MyRouter.login,
              builder: (context, state) => const LoginPage(),
              redirect: (context, state) {
                return FirebaseAuth.instance.currentUser != null
                    ? MyRouter.admin
                    : null;
              },
            ),
            GoRoute(
                path: MyRouter.admin,
                builder: (context, state) => const AdminPage(),
                redirect: (context, state) {
                  return FirebaseAuth.instance.currentUser == null
                      ? MyRouter.login
                      : null;
                },
                routes: [
                  GoRoute(
                    path: MyRouter.course(":id"),
                    builder: (context, state) =>
                        CourseEditingPage(state.params["id"]!),
                  ),
                ]),
          ],
        );

  static const String root = "/";
  static const String test = "/test";
  static const String login = "/login";
  static const String admin = "/admin";
  static String course(String id) => "course/$id";
}
