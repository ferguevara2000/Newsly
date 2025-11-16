import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/news_providers.dart';
import '../../domain/entities/article.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesAsync = ref.watch(articlesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Newsly')),
      body: articlesAsync.when(
        data: (articles) {
          if (articles.isEmpty) {
            return const Center(child: Text('No hay noticias disponibles.'));
          }

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (_, index) {
              final article = articles[index];
              return _ArticleTile(article: article);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Error al cargar noticias: $err')),
      ),
    );
  }
}

class _ArticleTile extends StatelessWidget {
  final Article article;
  const _ArticleTile({required this.article});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(article.title),
      subtitle: Text(
        article.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        context.push('/article/${article.id}');
      },
    );
  }
}
