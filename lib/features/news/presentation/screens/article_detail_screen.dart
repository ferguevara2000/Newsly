import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/news_providers.dart';
import '../../domain/entities/article.dart';

class ArticleDetailScreen extends ConsumerWidget {
  final String id;
  const ArticleDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(newsRepositoryProvider);

    return FutureBuilder<Article>(
      future: repo.getArticleById(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('No se encontró la noticia')),
          );
        }

        final article = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: Text(article.sourceName)),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                article.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                article.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              if (article.imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(article.imageUrl),
                ),
              const SizedBox(height: 16),
              Text(article.content),
            ],
          ),
        );
      },
    );
  }
}
