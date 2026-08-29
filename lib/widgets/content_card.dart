import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/content_article.dart';

/// Cor/ícone associados a cada categoria de conteúdo.
class _CategoryStyle {
  final Color color;
  final IconData icon;
  const _CategoryStyle(this.color, this.icon);

  static _CategoryStyle of(ContentCategory category) {
    switch (category) {
      case ContentCategory.extracao:
        return const _CategoryStyle(AppColors.primary, Icons.water_drop_outlined);
      case ContentCategory.armazenamento:
        return const _CategoryStyle(AppColors.secondary, Icons.ac_unit);
      case ContentCategory.amamentacao:
        return const _CategoryStyle(AppColors.accentPurple, Icons.child_care);
      case ContentCategory.doacao:
        return const _CategoryStyle(AppColors.accentOrange, Icons.volunteer_activism);
    }
  }
}

/// Card de um conteúdo educativo na listagem.
class ContentCard extends StatelessWidget {
  final ContentArticle article;
  final VoidCallback onTap;

  const ContentCard({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final style = _CategoryStyle.of(article.category);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: style.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(style.icon, color: style.color, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: style.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        article.category.label,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          color: style.color,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: AppColors.textStrong,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.summary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: AppColors.textMuted,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.schedule,
                            size: 13, color: AppColors.textSoft),
                        const SizedBox(width: 4),
                        Text(
                          article.readTime,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11,
                            color: AppColors.textSoft,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Ler artigo',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: style.color,
                          ),
                        ),
                        Icon(Icons.chevron_right, size: 16, color: style.color),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
