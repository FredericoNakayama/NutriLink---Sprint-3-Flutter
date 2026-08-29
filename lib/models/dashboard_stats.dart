/// Um indicador numérico exibido no dashboard do administrador.
class DashboardMetric {
  final String label;
  final String value;
  final String trend;

  const DashboardMetric({
    required this.label,
    required this.value,
    required this.trend,
  });
}

/// Linha da lista de agendamentos recentes no dashboard.
class RecentDonation {
  final String donorName;
  final String bankName;
  final String date;
  final String statusLabel;

  const RecentDonation({
    required this.donorName,
    required this.bankName,
    required this.date,
    required this.statusLabel,
  });
}
