// lib/features/news/data/datasources/firestore_news_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/article_model.dart';

class FirestoreNewsDatasource {
  final FirebaseFirestore _db;
  FirestoreNewsDatasource(this._db);

  Future<List<ArticleModel>> fetchArticles({
    String? category,
    int limit = 20,
  }) async {
    Query<Map<String, dynamic>> query = _db.collection('articles');

    if (category != null && category.isNotEmpty) {
      // 🔹 Solo filtramos por categoría (sin orderBy para evitar índice compuesto)
      query = query.where('category', isEqualTo: category).limit(limit);
    } else {
      // 🔹 Para "Todas" sí ordenamos por fecha
      query = query.orderBy('publishedAt', descending: true).limit(limit);
    }

    final snap = await query.get();

    return snap.docs.map((doc) => ArticleModel.fromDoc(doc)).toList();
  }

  Future<ArticleModel> getArticleById(String id) async {
    final doc = await _db.collection('articles').doc(id).get();
    return ArticleModel.fromDoc(doc);
  }
}
