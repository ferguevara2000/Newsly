import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../features/news/presentation/screens/home_screen.dart';
import '../features/news/presentation/screens/article_detail_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) {
        return const MaterialPage(child: HomeScreen());
      },
    ),
    GoRoute(
      path: '/article/:id',
      name: 'article_detail',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        return MaterialPage(child: ArticleDetailScreen(id: id));
      },
    ),
  ],
);
