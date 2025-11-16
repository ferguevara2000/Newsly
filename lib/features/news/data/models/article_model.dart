import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/article.dart';

class ArticleModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String content;
  final String category;
  final DateTime publishedAt;
  final String sourceName;
  final String? sourceUrl;

  ArticleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
    required this.category,
    required this.publishedAt,
    required this.sourceName,
    this.sourceUrl,
  });

  factory ArticleModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ArticleModel(
      id: doc.id,
      title: data['tittle'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      content: data['content'] ?? '',
      category: data['category'] ?? 'general',
      publishedAt: (data['publishedAt'] as Timestamp).toDate(),
      sourceName: data['sourceName'] ?? 'Unknown',
      sourceUrl: data['sourceUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'content': content,
      'category': category,
      'publishedAt': publishedAt,
      'sourceName': sourceName,
      'sourceUrl': sourceUrl,
    };
  }

  Article toEntity() {
    return Article(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      content: content,
      category: category,
      publishedAt: publishedAt,
      sourceName: sourceName,
      sourceUrl: sourceUrl,
    );
  }
}
