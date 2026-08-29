import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/milk_bank.dart';

/// Etiqueta colorida que identifica a rede do banco (Lactare / rBLH).
class NetworkBadge extends StatelessWidget {
  final MilkBankNetwork network;

  const NetworkBadge({super.key, required this.network});

  @override
  Widget build(BuildContext context) {
    final isLactare = network == MilkBankNetwork.lactare;
    final bg = isLactare ? AppColors.primaryLight : AppColors.secondaryLight;
    final fg = isLactare ? AppColors.primaryDark : AppColors.secondaryDark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        network.label,
        style: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
          fontSize: 11,
          color: fg,
        ),
      ),
    );
  }
}

/// Indicador de "Aberto" / "Fechado" com bolinha de status.
class OpenStatusPill extends StatelessWidget {
  final bool isOpen;

  const OpenStatusPill({super.key, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    final color = isOpen ? AppColors.success : AppColors.danger;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          isOpen ? 'Aberto' : 'Fechado',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
            fontSize: 11,
            color: color,
          ),
        ),
      ],
    );
  }
}
