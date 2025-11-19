import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import '../providers/news_providers.dart';
import '../../domain/entities/article.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesIds = ref.watch(favoritesProvider);
    final articlesAsync = ref.watch(allArticlesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: articlesAsync.when(
        data: (articles) {
          final favorites = articles
              .where((a) => favoritesIds.contains(a.id))
              .toList();

          if (favorites.isEmpty) {
            return const Center(
              child: Text('Aún no tienes noticias favoritas.'),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (_, index) {
              final article = favorites[index];
              return _FavoriteCard(article: article);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) =>
            Center(child: Text('Error al cargar favoritos: $err')),
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final Article article;

  const _FavoriteCard({required this.article});

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('dd MMM yyyy').format(article.publishedAt);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          context.push('/article/${article.id}');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl.isNotEmpty)
              Hero(
                tag: 'article-image-${article.id}',
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(article.imageUrl, fit: BoxFit.cover),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$dateFormatted · ${article.category.toUpperCase()}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
