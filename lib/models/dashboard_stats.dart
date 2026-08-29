/// Período usado no filtro de novos cadastros do dashboard.
enum RegistrationPeriod { dia, semana, mes, ano }

extension RegistrationPeriodLabel on RegistrationPeriod {
  /// Rótulo curto exibido no chip de filtro.
  String get label {
    switch (this) {
      case RegistrationPeriod.dia:
        return 'Dia';
      case RegistrationPeriod.semana:
        return 'Semana';
      case RegistrationPeriod.mes:
        return 'Mês';
      case RegistrationPeriod.ano:
        return 'Ano';
    }
  }

  /// Texto descritivo do período (ex.: "nas últimas 24 horas").
  String get description {
    switch (this) {
      case RegistrationPeriod.dia:
        return 'nas últimas 24 horas';
      case RegistrationPeriod.semana:
        return 'nos últimos 7 dias';
      case RegistrationPeriod.mes:
        return 'nos últimos 30 dias';
      case RegistrationPeriod.ano:
        return 'nos últimos 12 meses';
    }
  }
}

/// Um indicador percentual exibido no dashboard (ex.: taxa de adesão).
class RateMetric {
  final String label;
  final double percent;
  final String description;

  const RateMetric({
    required this.label,
    required this.percent,
    required this.description,
  });
}

/// Fatia do gráfico de origem de acessos (WhatsApp, Web ou App).
class AccessOrigin {
  final String label;
  final double percent;

  const AccessOrigin({required this.label, required this.percent});
}
