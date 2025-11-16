class Article {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String content;
  final String category; // ej: sports, politics, tech
  final DateTime publishedAt;
  final String sourceName;
  final String? sourceUrl;

  const Article({
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
}
