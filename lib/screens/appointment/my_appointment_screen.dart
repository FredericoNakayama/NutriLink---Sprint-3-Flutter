import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/appointment_store.dart';
import '../../models/appointment.dart';

/// Aba "Meu Agendamento": lista os agendamentos da nutriz.
///
/// Escuta o [AppointmentStore], de modo que novos agendamentos criados no
/// formulário aparecem automaticamente aqui.
class MyAppointmentScreen extends StatelessWidget {
  const MyAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppointmentStore.instance,
      builder: (context, _) {
        final appointments = AppointmentStore.instance.appointments;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Acompanhe suas coletas e consultas agendadas nos bancos de '
              'leite humano.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            for (final appointment in appointments) ...[
              _AppointmentCard(appointment: appointment),
              const SizedBox(height: 14),
            ],
          ],
        );
      },
    );
  }
}

class _StatusStyle {
  final Color color;
  final Color background;
  final IconData icon;
  const _StatusStyle(this.color, this.background, this.icon);

  static _StatusStyle of(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.confirmed:
        return const _StatusStyle(
            AppColors.secondary, AppColors.secondaryLight, Icons.check_circle);
      case AppointmentStatus.pending:
        return const _StatusStyle(
            AppColors.accentOrange, Color(0xFFFFF8F0), Icons.schedule);
      case AppointmentStatus.ongoing:
        return const _StatusStyle(
            AppColors.primary, AppColors.surfaceTint, Icons.autorenew);
    }
  }
}

class _AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const _AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final style = _StatusStyle.of(appointment.status);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: style.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(style.icon, color: style.color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.status.label,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: style.color,
                        ),
                      ),
                      Text(
                        'Ref: ${appointment.reference}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          color: AppColors.textSoft,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _DetailLine(
              icon: Icons.apartment_rounded,
              text: appointment.bank.name,
            ),
            const SizedBox(height: 8),
            _DetailLine(
              icon: Icons.event_outlined,
              text: appointment.formattedDate,
            ),
            const SizedBox(height: 8),
            _DetailLine(
              icon: Icons.access_time,
              text: 'Horário: ${appointment.time}',
            ),
            const SizedBox(height: 8),
            _DetailLine(
              icon: Icons.medical_services_outlined,
              text: appointment.type,
            ),
            const SizedBox(height: 8),
            _DetailLine(
              icon: Icons.location_on_outlined,
              text: appointment.bank.address,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailLine extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DetailLine({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              color: AppColors.textMuted,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
