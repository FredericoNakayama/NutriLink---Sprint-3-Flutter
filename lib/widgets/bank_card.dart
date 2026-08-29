import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/milk_bank.dart';
import 'badges.dart';

/// Card que resume um banco de leite na listagem de busca.
class BankCard extends StatelessWidget {
  final MilkBank bank;
  final VoidCallback onTap;

  const BankCard({super.key, required this.bank, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isLactare = bank.network == MilkBankNetwork.lactare;

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
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: isLactare
                      ? AppColors.primaryLight
                      : AppColors.secondaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.apartment_rounded,
                  color: isLactare ? AppColors.primary : AppColors.secondary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            bank.name,
                            style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColors.textStrong,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        NetworkBadge(network: bank.network),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      bank.address,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        OpenStatusPill(isOpen: bank.isOpen),
                        const SizedBox(width: 12),
                        const Icon(Icons.star_rounded,
                            size: 14, color: AppColors.accentOrange),
                        const SizedBox(width: 2),
                        Text(
                          bank.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          bank.distance,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11,
                            color: AppColors.textSoft,
                          ),
                        ),
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
