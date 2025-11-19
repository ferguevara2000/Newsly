import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
        final dateFormatted = DateFormat(
          'dd MMM yyyy, HH:mm',
        ).format(article.publishedAt);

        return Scaffold(
          appBar: AppBar(title: Text(article.sourceName)),
          floatingActionButton: article.sourceUrl != null
              ? FloatingActionButton.extended(
                  onPressed: () async {
                    final uri = Uri.parse(article.sourceUrl!);
                    if (!await launchUrl(
                      uri,
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw Exception('No se pudo abrir la URL');
                    }
                  },
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Ver fuente'),
                )
              : null,
          body: ListView(
            children: [
              if (article.imageUrl.isNotEmpty)
                Hero(
                  tag: 'article-image-${article.id}',
                  child: Image.network(article.imageUrl, fit: BoxFit.cover),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Categoría + fecha
                    Text(
                      article.category.toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateFormatted,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    // Título
                    Text(
                      article.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    // Descripción
                    Text(
                      article.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    // Contenido
                    Text(
                      article.content,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
