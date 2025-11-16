import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista dummy de noticias por ahora
    final articles = List.generate(
      10,
      (i) => {
        'id': 'article_$i',
        'title': 'Noticia #$i',
        'subtitle': 'Descripción corta de la noticia número $i',
      },
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Newsly')),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (_, index) {
          final article = articles[index];
          return ListTile(
            title: Text(article['title']!),
            subtitle: Text(article['subtitle']!),
            onTap: () {
              context.push('/article/${article['id']}');
            },
          );
        },
      ),
    );
  }
}
