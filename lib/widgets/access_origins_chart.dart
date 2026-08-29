import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/dashboard_stats.dart';

/// Gráfico de rosca (donut) que mostra a origem dos acessos que geraram
/// cadastro (WhatsApp, App, Web), acompanhado de uma legenda com percentuais.
class AccessOriginsChart extends StatelessWidget {
  final List<AccessOrigin> origins;

  const AccessOriginsChart({super.key, required this.origins});

  static const List<Color> _palette = [
    Color(0xFF25D366), // WhatsApp (verde)
    AppColors.primary, // App (azul)
    AppColors.accentPurple, // Web (roxo)
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 120,
          width: 120,
          child: CustomPaint(
            painter: _DonutPainter(origins: origins, palette: _palette),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${origins.length}',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: AppColors.textStrong,
                    ),
                  ),
                  const Text(
                    'canais',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      color: AppColors.textSoft,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < origins.length; i++) ...[
                _LegendRow(
                  color: _palette[i % _palette.length],
                  label: origins[i].label,
                  percent: origins[i].percent,
                ),
                if (i < origins.length - 1) const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _LegendRow extends StatelessWidget {
  final Color color;
  final String label;
  final double percent;

  const _LegendRow({
    required this.color,
    required this.label,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              color: AppColors.textMuted,
            ),
          ),
        ),
        Text(
          '${percent.toStringAsFixed(0)}%',
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w800,
            fontSize: 14,
            color: AppColors.textStrong,
          ),
        ),
      ],
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<AccessOrigin> origins;
  final List<Color> palette;

  _DonutPainter({required this.origins, required this.palette});

  @override
  void paint(Canvas canvas, Size size) {
    final total = origins.fold<double>(0, (sum, o) => sum + o.percent);
    if (total <= 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final stroke = radius * 0.34;
    final rect = Rect.fromCircle(center: center, radius: radius - stroke / 2);

    double startAngle = -math.pi / 2;
    const gap = 0.06; // pequeno espaço entre as fatias

    for (int i = 0; i < origins.length; i++) {
      final sweep = (origins[i].percent / total) * (2 * math.pi) - gap;
      final paint = Paint()
        ..color = palette[i % palette.length]
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(rect, startAngle + gap / 2, sweep, false, paint);
      startAngle += (origins[i].percent / total) * (2 * math.pi);
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) =>
      oldDelegate.origins != origins;
}
