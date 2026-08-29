import 'package:flutter/foundation.dart';

import '../models/appointment.dart';
import 'mock_appointments.dart';

/// Armazena os agendamentos em memória durante a sessão.
///
/// Simula um repositório: mantém o agendamento mockado inicial e recebe os
/// novos criados pelo formulário, notificando as telas que o escutam.
class AppointmentStore extends ChangeNotifier {
  AppointmentStore._() : _appointments = MockAppointments.initial();

  /// Instância única compartilhada pelo app.
  static final AppointmentStore instance = AppointmentStore._();

  final List<Appointment> _appointments;

  /// Agendamentos ordenados do mais recente para o mais antigo.
  List<Appointment> get appointments =>
      List.unmodifiable(_appointments.reversed);

  int get count => _appointments.length;

  void add(Appointment appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }
}
