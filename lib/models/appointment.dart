import 'milk_bank.dart';

/// Situação de um agendamento de coleta/consulta.
enum AppointmentStatus { confirmed, pending, ongoing }

extension AppointmentStatusInfo on AppointmentStatus {
  String get label {
    switch (this) {
      case AppointmentStatus.confirmed:
        return 'Confirmada';
      case AppointmentStatus.pending:
        return 'Pendente';
      case AppointmentStatus.ongoing:
        return 'Em Andamento';
    }
  }
}

/// Agendamento de visita ao banco de leite.
///
/// É criado tanto pelos dados mockados iniciais quanto pelo formulário de
/// agendamento preenchido pela nutriz.
class Appointment {
  final String reference;
  final MilkBank bank;
  final String donorName;
  final DateTime date;
  final String time;
  final String type;
  final AppointmentStatus status;

  const Appointment({
    required this.reference,
    required this.bank,
    required this.donorName,
    required this.date,
    required this.time,
    required this.type,
    required this.status,
  });

  static const List<String> months = [
    'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
    'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro',
  ];

  static const List<String> weekdays = [
    'Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira',
    'Sexta-feira', 'Sábado', 'Domingo',
  ];

  /// Data por extenso, ex.: "Quinta-feira, 05 de junho de 2026".
  String get formattedDate {
    final weekday = weekdays[date.weekday - 1];
    final day = date.day.toString().padLeft(2, '0');
    return '$weekday, $day de ${months[date.month - 1]} de ${date.year}';
  }

  /// Data curta, ex.: "05/06/2026".
  String get shortDate {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}
