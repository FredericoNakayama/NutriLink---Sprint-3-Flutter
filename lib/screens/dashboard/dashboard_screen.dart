import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/appointment_store.dart';
import '../../data/mock_dashboard.dart';
import '../../models/appointment.dart';
import '../../models/dashboard_stats.dart';

/// Aba "Dashboard": visão gerencial exclusiva do administrador.
///
/// Reúne indicadores mockados da rede e a lista de agendamentos recentes das
/// nutrizes (incluindo os criados durante a sessão).
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppointmentStore.instance,
      builder: (context, _) {
        final sessionAppointments = AppointmentStore.instance.appointments;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Visão geral da rede',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              'Indicadores consolidados das redes Lactare e rBLH.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.45,
              children: [
                for (final metric in MockDashboard.metrics)
                  _MetricCard(metric: metric),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'Agendamentos recentes',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceTint,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    '${sessionAppointments.length + MockDashboard.recentDonations.length} no total',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  // Agendamentos criados nesta sessão aparecem no topo.
                  for (final appointment in sessionAppointments)
                    _DonationRow(
                      donorName: appointment.donorName,
                      bankName: appointment.bank.name,
                      date: appointment.shortDate,
                      statusLabel: appointment.status.label,
                      highlighted: true,
                    ),
                  for (int i = 0;
                      i < MockDashboard.recentDonations.length;
                      i++)
                    _DonationRow(
                      donorName: MockDashboard.recentDonations[i].donorName,
                      bankName: MockDashboard.recentDonations[i].bankName,
                      date: MockDashboard.recentDonations[i].date,
                      statusLabel:
                          MockDashboard.recentDonations[i].statusLabel,
                      isLast: i == MockDashboard.recentDonations.length - 1,
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  final DashboardMetric metric;

  const _MetricCard({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              metric.value,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w800,
                fontSize: 26,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              metric.label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.trending_up,
                    size: 13, color: AppColors.secondary),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    metric.trend,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10,
                      color: AppColors.secondaryDark,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DonationRow extends StatelessWidget {
  final String donorName;
  final String bankName;
  final String date;
  final String statusLabel;
  final bool isLast;
  final bool highlighted;

  const _DonationRow({
    required this.donorName,
    required this.bankName,
    required this.date,
    required this.statusLabel,
    this.isLast = false,
    this.highlighted = false,
  });

  Color get _statusColor {
    switch (statusLabel) {
      case 'Confirmada':
        return AppColors.secondary;
      case 'Em Andamento':
        return AppColors.primary;
      case 'Pendente':
        return AppColors.accentOrange;
      default:
        return AppColors.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: highlighted ? AppColors.surfaceTint : null,
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primaryLight,
            child: Text(
              _initials(donorName),
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w800,
                fontSize: 12,
                color: AppColors.primaryDark,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donorName,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: AppColors.textStrong,
                  ),
                ),
                Text(
                  bankName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: _statusColor,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  color: AppColors.textSoft,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}
