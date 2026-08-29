import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/appointment.dart';
import '../../widgets/primary_button.dart';

/// Tela de confirmação exibida após o agendamento ser criado.
///
/// Dá o retorno visual da ação e resume os dados do [Appointment] gerado.
class AppointmentConfirmationScreen extends StatelessWidget {
  final Appointment appointment;

  const AppointmentConfirmationScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Center(
                child: Container(
                  height: 96,
                  width: 96,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.secondary,
                    size: 60,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Agendamento realizado!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Sua solicitação foi registrada e está aguardando confirmação '
                'do banco de leite. Você pode acompanhá-la em "Meu Agendamento".',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _SummaryRow(label: 'Referência', value: appointment.reference),
                    const Divider(height: 20),
                    _SummaryRow(label: 'Banco', value: appointment.bank.name),
                    const Divider(height: 20),
                    _SummaryRow(label: 'Data', value: appointment.shortDate),
                    const Divider(height: 20),
                    _SummaryRow(label: 'Horário', value: appointment.time),
                    const Divider(height: 20),
                    _SummaryRow(label: 'Tipo', value: appointment.type),
                  ],
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Concluir',
                icon: Icons.home_outlined,
                onPressed: () => Navigator.of(context)
                    .popUntil((route) => route.isFirst),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 92,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              color: AppColors.textSoft,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.textStrong,
            ),
          ),
        ),
      ],
    );
  }
}
