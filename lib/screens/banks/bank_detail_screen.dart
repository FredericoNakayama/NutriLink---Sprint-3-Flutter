import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_colors.dart';
import '../../models/milk_bank.dart';
import '../../widgets/badges.dart';
import '../../widgets/mock_map.dart';
import '../../widgets/primary_button.dart';

/// Detalhes de um banco de leite, recebido por parâmetro a partir da listagem.
///
/// Inclui um mapa ilustrativo da localização e um botão que abre o discador do
/// celular com o telefone do banco — o agendamento é feito por ligação, já que
/// muitos bancos de leite do Brasil atendem apenas por telefone.
class BankDetailScreen extends StatelessWidget {
  final MilkBank bank;

  const BankDetailScreen({super.key, required this.bank});

  Future<void> _callBank(BuildContext context) async {
    // Mantém apenas os dígitos para compor o esquema tel:.
    final digits = bank.phone.replaceAll(RegExp(r'[^0-9]'), '');
    final uri = Uri(scheme: 'tel', path: digits);

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Não foi possível abrir o discador. Ligue para ${bank.phone}.'),
            backgroundColor: AppColors.warning,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLactare = bank.network == MilkBankNetwork.lactare;
    final accent = isLactare ? AppColors.primary : AppColors.secondary;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Banco')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accent, isLactare ? AppColors.primaryDark : AppColors.secondaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.apartment_rounded,
                          color: Colors.white, size: 26),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Rede ${bank.network.label}',
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  bank.name,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: OpenStatusPill(isOpen: bank.isOpen),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.star_rounded,
                        size: 16, color: Colors.white),
                    const SizedBox(width: 3),
                    Text(
                      bank.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Mapa ilustrativo da localização.
          Text('Localização', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          MockMapView(label: bank.name, accent: accent),
          const SizedBox(height: 16),

          _InfoTile(
            icon: Icons.location_on_outlined,
            title: 'Endereço',
            value: '${bank.address}\n${bank.cep}',
          ),
          _InfoTile(
            icon: Icons.schedule,
            title: 'Horário de funcionamento',
            value: bank.hours,
          ),
          _InfoTile(
            icon: Icons.phone_outlined,
            title: 'Telefone',
            value: bank.phone,
          ),
          _InfoTile(
            icon: Icons.near_me_outlined,
            title: 'Distância aproximada',
            value: bank.distance,
          ),
          const SizedBox(height: 8),

          // O agendamento é feito por telefone (abre o discador do celular).
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceTint,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 18, color: AppColors.primaryDark),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'O agendamento da visita é feito diretamente com o banco '
                    'por telefone. Toque abaixo para ligar.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
          PrimaryButton(
            label: 'Ligar para agendar',
            icon: Icons.phone,
            color: accent,
            onPressed: () => _callBank(context),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.surfaceTint,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: AppColors.textSoft,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.textStrong,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
