import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/article.dart';
import '../../domain/repositories/news_repository.dart';
import '../../data/datasources/firestore_news_datasource.dart';
import '../../data/repositories/news_repository_impl.dart';

/// Provider del repositorio
final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  final firestore = FirebaseFirestore.instance;
  final datasource = FirestoreNewsDatasource(firestore);
  return NewsRepositoryImpl(datasource: datasource);
});

/// Provider para la lista de artículos
final articlesProvider = FutureProvider<List<Article>>((ref) async {
  final repo = ref.watch(newsRepositoryProvider);
  // después podremos pasar category
  return repo.fetchArticles();
});
