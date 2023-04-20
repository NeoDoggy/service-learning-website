import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service_learning_website/pages/admin_page.dart';
import 'package:service_learning_website/pages/home_page.dart';
import 'package:service_learning_website/pages/login_page.dart';
import 'package:service_learning_website/test/test_page.dart';

class MyRouter extends GoRouter {

  MyRouter() : super(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: MyRouter.root,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: MyRouter.test,
        builder: (context, state) => const TestPage(),
      ),
      GoRoute(
        path: MyRouter.login,
        builder: (context, state) => const LoginPage(),
        redirect: (context, state) {
          return FirebaseAuth.instance.currentUser != null ? MyRouter.root : null;
        },
      ),
      GoRoute(
        path: MyRouter.admin,
        builder: (context, state) => const AdminPage(),
      ),
    ],
  );

  static const String root = "/";
  static const String test = "/test";
  static const String login = "/login";
  static const String admin = "/admin";
}