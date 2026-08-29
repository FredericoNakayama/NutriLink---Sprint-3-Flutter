import '../models/appointment.dart';
import 'mock_banks.dart';

/// Agendamento inicial mockado exibido na aba "Meu Agendamento".
class MockAppointments {
  MockAppointments._();

  static List<Appointment> initial() => [
        Appointment(
          reference: 'AGD-2026-04892',
          bank: MockBanks.all[0],
          donorName: 'Ana Maria Ribeiro',
          date: DateTime(2026, 9, 10),
          time: '09:30',
          type: 'Coleta de Leite + Consulta',
          status: AppointmentStatus.confirmed,
        ),
      ];
}
