import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:service_learning_website/pages/activities_page/activities_browsing_page.dart';
import 'package:service_learning_website/pages/activities_page/activity_intro.dart';
import 'package:service_learning_website/pages/admin_page/activity_editing_page/activity_editing_page.dart';
import 'package:service_learning_website/pages/admin_page/admin_page.dart';
import 'package:service_learning_website/pages/admin_page/article_editing_page/article_editing_page.dart';
import 'package:service_learning_website/pages/articles_page/article_page.dart';
import 'package:service_learning_website/pages/admin_page/course_editing_page/chapter_editing_page.dart';
import 'package:service_learning_website/pages/admin_page/course_editing_page/course_editing_page.dart';
import 'package:service_learning_website/pages/articles_page/articles_browsing_page.dart';
import 'package:service_learning_website/pages/courses_page/course_intro.dart';
import 'package:service_learning_website/pages/courses_page/course_page.dart';
import 'package:service_learning_website/pages/courses_page/courses_browsing_page.dart';
import 'package:service_learning_website/pages/login_page.dart';
import 'package:service_learning_website/pages/welcome_page.dart';
import 'package:service_learning_website/test/test_page.dart';
import 'package:service_learning_website/pages/backstage_page/backstage_page.dart';

class MyRouter {
  static const String test = "test";
  static const String login = "login";
  static const String admin = "admin";
  static const String activities = "activities";
  static const String courses = "courses";
  static const String intro = "intro";
  static const String articles = "articles";
  static const String backstage = "backstage";

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
                path: MyRouter.backstage,
                builder: (context, state) => const BackstagePage(),
              ),
              GoRoute(
                path: MyRouter.activities,
                builder: (context, state) => const ActivitiesBrowsingPage(),
                routes: [
                  GoRoute(
                    path: ":activityId/${MyRouter.intro}",
                    builder: (context, state) =>
                        ActivityIntro(activityId: state.params["activityId"]!),
                  ),
                ],
              ),
              GoRoute(
                  path: MyRouter.articles,
                  builder: (context, state) => const ArticlesBrowsingPage(),
                  routes: [
                    GoRoute(
                      path: ":articleId",
                      builder: (context, state) =>
                          ArticlePage(articleId: state.params["articleId"]!),
                    ),
                  ]),
              GoRoute(
                path: MyRouter.courses,
                builder: (context, state) => const CoursesBrowsingPage(),
                routes: [
                  GoRoute(
                    path: ":courseId",
                    builder: (context, state) => CoursePage(
                        courseId: state.params["courseId"]!,
                        chapterId: state.queryParams["chapter"]),
                  ),
                  GoRoute(
                    path: ":courseId/${MyRouter.intro}",
                    builder: (context, state) =>
                        CourseIntro(courseId: state.params["courseId"]!),
                  ),
                ],
              ),
              GoRoute(
                path: MyRouter.login,
                builder: (context, state) => const LoginPage(),
                redirect: (context, state) {
                  return FirebaseAuth.instance.currentUser != null ? "/" : null;
                },
              ),
              GoRoute(
                path: MyRouter.admin,
                builder: (context, state) => const AdminPage(),
                redirect: (context, state) {
                  return FirebaseAuth.instance.currentUser == null
                      ? "/${MyRouter.login}"
                      : null;
                },
                routes: [
                  GoRoute(
                    path: "${MyRouter.activities}/:activityId",
                    builder: (context, state) =>
                        ActivityEditingPage(state.params["activityId"]!),
                  ),
                  GoRoute(
                    path: "${MyRouter.articles}/:articleId",
                    builder: (context, state) =>
                        ArticleEditingPage(state.params["articleId"]!),
                  ),
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
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
