import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/mock_dashboard.dart';
import '../../models/dashboard_stats.dart';
import '../../widgets/access_origins_chart.dart';

/// Aba "Dashboard": visão gerencial exclusiva do administrador.
///
/// Reúne indicadores da rede (total de cadastros, taxas de comprometimento e
/// adesão), um gráfico de origem dos acessos e um filtro de novos cadastros
/// por período (dia, semana, mês, ano).
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  RegistrationPeriod _period = RegistrationPeriod.mes;

  /// Formata inteiros com ponto como separador de milhar (padrão pt-BR).
  String _formatNumber(int value) {
    final digits = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final newRegistrations = MockDashboard.newRegistrations[_period]!;
    final trend = MockDashboard.registrationTrend[_period]!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Visão geral da rede', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(
          'Indicadores consolidados das redes Lactare e rBLH.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),

        // ── Filtro de novos cadastros por período ──────────────
        Text(
          'Novos cadastros de nutrizes',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            for (final period in RegistrationPeriod.values) ...[
              _PeriodChip(
                label: period.label,
                selected: _period == period,
                onTap: () => setState(() => _period = period),
              ),
              if (period != RegistrationPeriod.values.last)
                const SizedBox(width: 8),
            ],
          ],
        ),
        const SizedBox(height: 12),
        _NewRegistrationsCard(
          value: _formatNumber(newRegistrations),
          period: _period,
          trend: trend,
        ),
        const SizedBox(height: 24),

        // ── Indicadores principais ─────────────────────────────
        Text('Indicadores', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        _MetricCard(
          icon: Icons.groups_outlined,
          value: _formatNumber(MockDashboard.totalNutrizes),
          label: 'Total de nutrizes cadastradas',
          accent: AppColors.primary,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _RateCard(metric: MockDashboard.taxaComprometimento),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _RateCard(metric: MockDashboard.taxaAdesao),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // ── Gráfico de origem de acessos ───────────────────────
        Text(
          'Origem dos acessos',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Text(
          'Por onde as nutrizes chegaram até a plataforma.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: AccessOriginsChart(origins: MockDashboard.accessOrigins),
          ),
        ),
      ],
    );
  }
}

class _PeriodChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _PeriodChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 9),
          alignment: Alignment.center,
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

class _NewRegistrationsCard extends StatelessWidget {
  final String value;
  final RegistrationPeriod period;
  final String trend;

  const _NewRegistrationsCard({
    required this.value,
    required this.period,
    required this.trend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    fontSize: 34,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'novos cadastros ${period.description}',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.trending_up, size: 15, color: Colors.white),
                    const SizedBox(width: 5),
                    Text(
                      trend,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_add_alt_1, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color accent;

  const _MetricCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: accent, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      color: AppColors.textStrong,
                    ),
                  ),
                  Text(
                    label,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: AppColors.textMuted,
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

class _RateCard extends StatelessWidget {
  final RateMetric metric;

  const _RateCard({required this.metric});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${metric.percent.toStringAsFixed(1).replaceAll('.', ',')}%',
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w800,
                fontSize: 26,
                color: AppColors.secondaryDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              metric.label,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: AppColors.textStrong,
              ),
            ),
            const SizedBox(height: 8),
            // Barra de progresso proporcional à taxa.
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: LinearProgressIndicator(
                value: metric.percent / 100,
                minHeight: 6,
                backgroundColor: AppColors.surfaceTint,
                valueColor: const AlwaysStoppedAnimation(AppColors.secondary),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              metric.description,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 11,
                color: AppColors.textSoft,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
