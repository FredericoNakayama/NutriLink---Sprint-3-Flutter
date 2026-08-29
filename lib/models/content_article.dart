/// Categoria de um conteúdo educativo.
enum ContentCategory { extracao, armazenamento, amamentacao, doacao }

extension ContentCategoryLabel on ContentCategory {
  String get label {
    switch (this) {
      case ContentCategory.extracao:
        return 'Extração';
      case ContentCategory.armazenamento:
        return 'Armazenamento';
      case ContentCategory.amamentacao:
        return 'Amamentação';
      case ContentCategory.doacao:
        return 'Doação';
    }
  }
}

/// Um bloco de texto de um artigo (subtítulo + parágrafo).
class ContentSection {
  final String heading;
  final String body;

  const ContentSection({required this.heading, required this.body});
}

/// Conteúdo educativo (guia/artigo) do espaço educativo do NutriLink.
class ContentArticle {
  final String id;
  final ContentCategory category;
  final String title;
  final String summary;
  final String readTime;
  final List<ContentSection> sections;

  /// Título da videoaula que acompanha o guia (representada por uma
  /// thumbnail mockada — não há vídeo real reproduzível nesta Sprint).
  final String videoTitle;

  /// Duração exibida na thumbnail do vídeo (ex.: "3:20").
  final String videoDuration;

  const ContentArticle({
    required this.id,
    required this.category,
    required this.title,
    required this.summary,
    required this.readTime,
    required this.sections,
    required this.videoTitle,
    required this.videoDuration,
  });
}
