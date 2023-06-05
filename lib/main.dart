import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/my_router.dart';
import 'package:service_learning_website/firebase_options.dart';
import 'package:service_learning_website/providers/activities_provider.dart';
import 'package:service_learning_website/providers/articles_provider.dart';
import 'package:service_learning_website/providers/courses_provider.dart';
import 'package:service_learning_website/providers/floating_window_provider.dart';
import 'package:service_learning_website/providers/problems_provider.dart';
import 'package:service_learning_website/providers/users_provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.authStateChanges().first;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FloatingWindowProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => CoursesProvider()),
        ChangeNotifierProvider(create: (_) => ActivitiesProvider()),
        ChangeNotifierProvider(create: (_) => ArticlesProvider()),
        ChangeNotifierProvider(create: (_) => ProblemsProvider()),
      ],
      child: MaterialApp.router(
        title: "NCU CS Tutorial Platform",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        routerConfig: MyRouter().router,
      ),
    );
  }
}
