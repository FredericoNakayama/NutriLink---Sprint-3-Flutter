import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/appointment_store.dart';
import '../../data/mock_users.dart';
import '../../models/appointment.dart';
import '../../models/milk_bank.dart';
import '../../widgets/primary_button.dart';
import 'appointment_confirmation_screen.dart';

/// Formulário de agendamento de visita a um banco de leite.
///
/// Recebe o [MilkBank] escolhido, coleta os dados da coleta e cria um novo
/// [Appointment] no [AppointmentStore].
class AppointmentFormScreen extends StatefulWidget {
  final MilkBank bank;

  const AppointmentFormScreen({super.key, required this.bank});

  @override
  State<AppointmentFormScreen> createState() => _AppointmentFormScreenState();
}

class _AppointmentFormScreenState extends State<AppointmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: MockUsers.nutriz.name);

  DateTime? _selectedDate;
  String? _selectedTime;
  String _type = 'Coleta de Leite + Consulta';

  static const _times = ['08:00', '09:30', '11:00', '13:30', '15:00', '16:30'];
  static const _types = [
    'Coleta de Leite + Consulta',
    'Apenas Coleta de Leite',
    'Triagem de Nova Doadora',
    'Coleta Domiciliar Assistida',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 90)),
      helpText: 'Escolha a data da visita',
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null) {
      _showError('Selecione a data da visita.');
      return;
    }
    if (_selectedTime == null) {
      _showError('Selecione um horário disponível.');
      return;
    }

    final reference =
        'AGD-2026-${(5000 + AppointmentStore.instance.count * 137 % 4000)}';
    final appointment = Appointment(
      reference: reference,
      bank: widget.bank,
      donorName: _nameController.text.trim(),
      date: _selectedDate!,
      time: _selectedTime!,
      type: _type,
      status: AppointmentStatus.pending,
    );

    AppointmentStore.instance.add(appointment);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => AppointmentConfirmationScreen(appointment: appointment),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), backgroundColor: AppColors.warning),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agendar Visita')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _BankSummary(bank: widget.bank),
            const SizedBox(height: 20),
            const _Label('Nome da doadora'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Seu nome completo',
                prefixIcon: Icon(Icons.person_outline, size: 20),
              ),
              validator: (v) => (v == null || v.trim().length < 3)
                  ? 'Informe o nome da doadora'
                  : null,
            ),
            const SizedBox(height: 18),
            const _Label('Data da visita'),
            const SizedBox(height: 6),
            InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(14),
              child: InputDecorator(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                ),
                child: Text(
                  _selectedDate == null
                      ? 'Toque para escolher a data'
                      : _formatDate(_selectedDate!),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: _selectedDate == null
                        ? AppColors.textSoft
                        : AppColors.textStrong,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const _Label('Horário disponível'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final time in _times)
                  _TimeChip(
                    time: time,
                    selected: _selectedTime == time,
                    onTap: () => setState(() => _selectedTime = time),
                  ),
              ],
            ),
            const SizedBox(height: 18),
            const _Label('Tipo de atendimento'),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: _type,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.medical_services_outlined, size: 18),
              ),
              items: [
                for (final t in _types)
                  DropdownMenuItem(value: t, child: Text(t, overflow: TextOverflow.ellipsis)),
              ],
              onChanged: (v) => setState(() => _type = v ?? _type),
            ),
            const SizedBox(height: 28),
            PrimaryButton(
              label: 'Confirmar Agendamento',
              icon: Icons.check_circle_outline,
              onPressed: _submit,
            ),
            const SizedBox(height: 12),
            Text(
              'Ao confirmar, você poderá acompanhar o status na aba '
              '"Meu Agendamento".',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final weekday = Appointment.weekdays[date.weekday - 1];
    return '$weekday, $day de ${Appointment.months[date.month - 1]} de ${date.year}';
  }
}

class _BankSummary extends StatelessWidget {
  final MilkBank bank;
  const _BankSummary({required this.bank});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceTint,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.apartment_rounded, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bank.name,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.textStrong,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  bank.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w700,
        fontSize: 13,
        color: AppColors.textStrong,
      ),
    );
  }
}

class _TimeChip extends StatelessWidget {
  final String time;
  final bool selected;
  final VoidCallback onTap;

  const _TimeChip({
    required this.time,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: selected ? Colors.white : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}
