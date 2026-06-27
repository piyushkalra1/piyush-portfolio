import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/sections/main_portfolio_page.dart';
import 'package:portfolio/theme/app_theme.dart';

void main() {
  // Ensure widgets binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(const MyApp());
  runApp(const MyApp());
}

// GoRouter configuration with support for deep-linked sections (e.g., /projects, /about)
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainPortfolioPage(initialSection: "Hero");
      },
      routes: <RouteBase>[
        GoRoute(
          path: ':section',
          builder: (BuildContext context, GoRouterState state) {
            final sectionParam = state.pathParameters['section'] ?? 'Hero';
            // Normalize path parameter to match section keys (e.g., 'about' -> 'About')
            final formattedSection = sectionParam.isNotEmpty
                ? '${sectionParam[0].toUpperCase()}${sectionParam.substring(1).toLowerCase()}'
                : 'Hero';
            return MainPortfolioPage(initialSection: formattedSection);
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Piyush Kalra | Senior Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: _router,
    );
  }
}
