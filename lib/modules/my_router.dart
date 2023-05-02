import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:service_learning_website/pages/admin_page/admin_page.dart';
import 'package:service_learning_website/pages/course_editing_page/course_editing_page.dart';
import 'package:service_learning_website/pages/login_page.dart';
import 'package:service_learning_website/pages/welcome_page.dart';
import 'package:service_learning_website/test/test_page.dart';
import 'package:service_learning_website/pages/backstage_page/backstage_page.dart';

class MyRouter {
  GoRouter get router => GoRouter(
        initialLocation: MyRouter.root,
        routes: [
          GoRoute(
            path: MyRouter.root,
            builder: (context, state) => const WelcomePage(),
          ),
          GoRoute(
            path: MyRouter.test,
            builder: (context, state) => const TestPage(),
          ),
          GoRoute(
            path: MyRouter.login,
            builder: (context, state) => const LoginPage(),
            redirect: (context, state) {
              // final authProvider = Provider.of<AuthProvider>(context);
              // return authProvider.isAuthed ? MyRouter.admin : null;

              return FirebaseAuth.instance.currentUser != null
                  ? MyRouter.admin
                  : null;
            },
          ),
          GoRoute(
            path: MyRouter.backstage,
            builder: (context, state) => const BackstagePage(),
          ),
          GoRoute(
              path: MyRouter.admin,
              builder: (context, state) => const AdminPage(),
              redirect: (context, state) {
                // final authProvider = Provider.of<AuthProvider>(context);
                // return !authProvider.isAuthed
                //     ? MyRouter.login
                //     : authProvider.userData!.permission < UserPermission.student
                //         ? MyRouter.root
                //         : null;

                // if (!authProvider.isAuthed) return MyRouter.login;
                // if (authProvider.userData!.permission <
                //     UserPermission.student) return MyRouter.root;
                // return null;

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
  static const String backstage = "/backstage";
  static String course(String id) => "course/$id";
}
