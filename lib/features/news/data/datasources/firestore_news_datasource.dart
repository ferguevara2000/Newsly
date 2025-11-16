import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/article_model.dart';

class FirestoreNewsDatasource {
  final FirebaseFirestore _db;
  FirestoreNewsDatasource(this._db);

  Future<List<ArticleModel>> fetchArticles({
    String? category,
    int limit = 20,
  }) async {
    Query<Map<String, dynamic>> query = _db
        .collection('articles')
        .orderBy('publishedAt', descending: true);

    if (category != null && category.isNotEmpty) {
      query = query.where('category', isEqualTo: category);
    }

    query = query.limit(limit);

    final snap = await query.get();
    return snap.docs.map((doc) => ArticleModel.fromDoc(doc)).toList();
  }

  Future<ArticleModel> getArticleById(String id) async {
    final doc = await _db.collection('articles').doc(id).get();
    return ArticleModel.fromDoc(doc);
  }
}
