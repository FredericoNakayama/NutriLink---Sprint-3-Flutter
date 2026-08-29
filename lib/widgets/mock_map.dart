import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Mapa ilustrativo (mockado) que posiciona o banco selecionado.
///
/// Não usa API de mapas: o traçado de ruas e quarteirões é desenhado com um
/// [CustomPainter], e um pin marca a localização aproximada do banco.
class MockMapView extends StatelessWidget {
  final String label;
  final Color accent;

  const MockMapView({
    super.key,
    required this.label,
    this.accent = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 190,
        color: const Color(0xFFE8F0F8),
        child: Stack(
          children: [
            // Traçado de ruas e quarteirões.
            Positioned.fill(
              child: CustomPaint(painter: _StreetsPainter()),
            ),

            // Pin central com rótulo do banco.
            Align(
              alignment: const Alignment(0, -0.1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    margin: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: AppColors.textStrong,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.favorite, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),

            // Legenda de mapa ilustrativo.
            Positioned(
              left: 10,
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Text(
                  'Mapa ilustrativo',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StreetsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final block = Paint()..color = const Color(0xFFD6EAFF).withValues(alpha: 0.45);
    final wideStreet = Paint()
      ..color = const Color(0xFF3A7AB8).withValues(alpha: 0.28)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    final thinStreet = Paint()
      ..color = const Color(0xFF5BA4D4).withValues(alpha: 0.25)
      ..strokeWidth = 4;

    // Quarteirões.
    final blocks = [
      Rect.fromLTWH(size.width * 0.06, size.height * 0.12, 70, 44),
      Rect.fromLTWH(size.width * 0.60, size.height * 0.10, 90, 40),
      Rect.fromLTWH(size.width * 0.10, size.height * 0.62, 80, 46),
      Rect.fromLTWH(size.width * 0.66, size.height * 0.60, 74, 50),
    ];
    for (final r in blocks) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(4)),
        block,
      );
    }

    // Avenidas largas (diagonais e horizontais).
    canvas.drawLine(
      Offset(0, size.height * 0.34),
      Offset(size.width, size.height * 0.30),
      wideStreet,
    );
    canvas.drawLine(
      Offset(size.width * 0.30, 0),
      Offset(size.width * 0.34, size.height),
      wideStreet,
    );

    // Ruas finas em grade.
    for (double y = size.height * 0.14; y < size.height; y += size.height * 0.22) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y - 6), thinStreet);
    }
    for (double x = size.width * 0.16; x < size.width; x += size.width * 0.24) {
      canvas.drawLine(Offset(x, 0), Offset(x + 6, size.height), thinStreet);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
