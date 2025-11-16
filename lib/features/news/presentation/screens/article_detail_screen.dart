import 'package:flutter/material.dart';

class ArticleDetailScreen extends StatelessWidget {
  final String id;
  const ArticleDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // Por ahora solo mostramos el id
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de noticia')),
      body: Center(child: Text('Detalle de la noticia con id: $id')),
    );
  }
}
