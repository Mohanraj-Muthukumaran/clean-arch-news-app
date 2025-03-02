import 'package:cleanarchnews/features/daily_news/domain/entities/article.dart';
import 'package:cleanarchnews/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:cleanarchnews/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:cleanarchnews/features/daily_news/presentation/pages/saved_articles/saved_articles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    // Home Screen Route
    GoRoute(
      path: '/',
      builder: (context, state) => const DailyNews(),
    ),

    // Article Details Route
    GoRoute(
      path: '/articleDetails',
      builder: (context, state) {
        final article = state.extra as ArticleEntity?;
        if (article == null) {
          return const ErrorScreen();
        }
        return ArticleDetailsView(article: article);
      },
    ),

     // Saved Articles Route
    GoRoute(
      path: '/savedArticles',
      builder: (context, state) => const SavedArticles(),
    ),
  ],
);

class ErrorScreen extends StatelessWidget {

  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: const Center(child: Text("Invalid route or missing data")),
    );
  }
}