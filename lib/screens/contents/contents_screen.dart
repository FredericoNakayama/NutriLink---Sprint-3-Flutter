import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/mock_contents.dart';
import '../../models/content_article.dart';
import '../../widgets/content_card.dart';
import 'content_detail_screen.dart';

/// Aba "Conteúdos": espaço educativo com guias e artigos para nutrizes.
///
/// Permite filtrar por categoria e abre a tela de detalhes passando o
/// [ContentArticle] selecionado.
class ContentsScreen extends StatefulWidget {
  const ContentsScreen({super.key});

  @override
  State<ContentsScreen> createState() => _ContentsScreenState();
}

class _ContentsScreenState extends State<ContentsScreen> {
  ContentCategory? _category;

  List<ContentArticle> get _filtered {
    if (_category == null) return MockContents.all;
    return MockContents.all.where((a) => a.category == _category).toList();
  }

  void _openDetail(ContentArticle article) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ContentDetailScreen(article: article)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final articles = _filtered;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          color: AppColors.surfaceTint,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Espaço Educativo',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'Tudo o que você precisa saber para cuidar, extrair e doar com '
                'segurança.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            children: [
              _CategoryChip(
                label: 'Todos',
                selected: _category == null,
                onTap: () => setState(() => _category = null),
              ),
              for (final category in ContentCategory.values)
                _CategoryChip(
                  label: category.label,
                  selected: _category == category,
                  onTap: () => setState(() => _category = category),
                ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: articles.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (_, i) => ContentCard(
              article: articles[i],
              onTap: () => _openDetail(articles[i]),
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: selected ? Colors.white : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}
