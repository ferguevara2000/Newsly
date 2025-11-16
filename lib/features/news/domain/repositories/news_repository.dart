import '../entities/article.dart';

abstract class NewsRepository {
  Future<List<Article>> fetchArticles({String? category, int limit = 20});

  Future<Article> getArticleById(String id);
}
