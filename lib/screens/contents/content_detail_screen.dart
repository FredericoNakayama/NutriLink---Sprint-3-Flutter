import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/content_article.dart';
import '../../widgets/video_thumbnail.dart';

/// Detalhe de um conteúdo educativo, recebido por parâmetro a partir da lista.
class ContentDetailScreen extends StatelessWidget {
  final ContentArticle article;

  const ContentDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conteúdo')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.surfaceTint,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              article.category.label,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: AppColors.primaryDark,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(article.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.schedule, size: 14, color: AppColors.textSoft),
              const SizedBox(width: 4),
              Text(
                article.readTime,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: AppColors.textSoft,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            article.summary,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              color: AppColors.textStrong,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          // Videoaula mockada que acompanha o guia.
          Row(
            children: [
              const Icon(Icons.videocam_outlined, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Text('Videoaula', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 10),
          VideoThumbnail(
            title: article.videoTitle,
            duration: article.videoDuration,
          ),
          const Divider(height: 32),
          for (final section in article.sections) ...[
            Text(section.heading, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              section.body,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: AppColors.textMuted,
                height: 1.55,
              ),
            ),
            const SizedBox(height: 20),
          ],
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondaryLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFC8E8D8)),
            ),
            child: Row(
              children: [
                const Icon(Icons.favorite_rounded,
                    color: AppColors.secondary, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Cada gota de leite humano doado é um ato de amor que '
                    'salva vidas.',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: AppColors.secondaryDark,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
