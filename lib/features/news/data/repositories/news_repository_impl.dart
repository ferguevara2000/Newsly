import '../../domain/entities/article.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/firestore_news_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final FirestoreNewsDatasource datasource;

  NewsRepositoryImpl({required this.datasource});

  @override
  Future<List<Article>> fetchArticles({
    String? category,
    int limit = 20,
  }) async {
    final models = await datasource.fetchArticles(
      category: category,
      limit: limit,
    );
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Article> getArticleById(String id) async {
    final model = await datasource.getArticleById(id);
    return model.toEntity();
  }
}
