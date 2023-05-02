import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service_learning_website/pages/admin_page/admin_page.dart';
import 'package:service_learning_website/pages/course_editing_page/chapter_editing_page.dart';
import 'package:service_learning_website/pages/course_editing_page/course_editing_page.dart';
import 'package:service_learning_website/pages/course_intro.dart';
import 'package:service_learning_website/pages/login_page.dart';
import 'package:service_learning_website/pages/welcome_page.dart';
import 'package:service_learning_website/test/test_page.dart';

class MyRouter {
  GoRouter get router => GoRouter(
        initialLocation: "/",
        routes: [
          GoRoute(
            path: "/",
            builder: (context, state) => const WelcomePage(),
            routes: [
              GoRoute(
                path: MyRouter.test,
                builder: (context, state) => const TestPage(),
              ),
              GoRoute(
                  path: MyRouter.courses,
                  builder: (context, state) => const Placeholder(),
                  routes: [
                    GoRoute(
                        path: ":courseId",
                        builder: (context, state) =>
                            CourseIntro(courseId: state.params["courseId"]!))
                  ]),
              GoRoute(
                path: MyRouter.login,
                builder: (context, state) => const LoginPage(),
                redirect: (context, state) {
                  // final authProvider = Provider.of<AuthProvider>(context);
                  // return authProvider.isAuthed ? MyRouter.admin : null;

                  return FirebaseAuth.instance.currentUser != null
                      ? "/${MyRouter.admin}"
                      : null;
                },
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

                    return FirebaseAuth.instance.currentUser == null
                        ? "/${MyRouter.login}"
                        : null;
                  },
                  routes: [
                    GoRoute(
                        path: "${MyRouter.courses}/:courseId",
                        builder: (context, state) =>
                            CourseEditingPage(state.params["courseId"]!),
                        routes: [
                          GoRoute(
                              path: ":chapterId",
                              builder: (context, state) => ChapterEditingPage(
                                  state.params["courseId"]!,
                                  state.params["chapterId"]!))
                        ]),
                  ]),
            ],
          ),
        ],
      );

  static const String test = "test";
  static const String login = "login";
  static const String admin = "admin";
  static const String courses = "courses";
  // static String course(String id) => "course/$id";
  // static String chapter(String courseId, String chapterId) => "course/$courseId/$chapterId";
}
