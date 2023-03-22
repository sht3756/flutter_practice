import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/screen/about_screen.dart';
import 'package:portfolio/screen/blog_screen.dart';
import 'package:portfolio/screen/carrer_screen.dart';
import 'package:portfolio/screen/error_screen.dart';
import 'package:portfolio/screen/home_screen.dart';
import 'package:portfolio/screen/project_screen.dart';
import 'package:portfolio/screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
      initialLocation: '/project',
      errorBuilder: (context, state) => const ErrorScreen(),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/project',
          builder: (context, state) => const ProjectScreen(),
        ),
        GoRoute(
          path: '/career',
          builder: (context, state) => const CarrerScreen(),
        ),
        GoRoute(
          path: '/blog',
          builder: (context, state) => const BlogScreen(),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const AboutScreen(),
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      darkTheme: ThemeData(),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Hizzang',
      // home: HomeScreen(),
    );
  }
}
