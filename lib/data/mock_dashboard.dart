import '../models/dashboard_stats.dart';

/// Dados mockados do dashboard do administrador.
class MockDashboard {
  MockDashboard._();

  /// Total acumulado de nutrizes cadastradas na plataforma.
  static const int totalNutrizes = 48210;

  /// Taxa de comprometimento: doadoras que mantêm as coletas agendadas.
  static const RateMetric taxaComprometimento = RateMetric(
    label: 'Taxa de comprometimento',
    percent: 87.4,
    description: 'doadoras que comparecem às coletas agendadas',
  );

  /// Taxa de adesão: cadastros que se tornam doadoras ativas.
  static const RateMetric taxaAdesao = RateMetric(
    label: 'Taxa de adesão',
    percent: 92.1,
    description: 'cadastros que concluem a primeira doação',
  );

  /// Novos cadastros de nutrizes por período de filtro.
  static const Map<RegistrationPeriod, int> newRegistrations = {
    RegistrationPeriod.dia: 34,
    RegistrationPeriod.semana: 212,
    RegistrationPeriod.mes: 1284,
    RegistrationPeriod.ano: 14905,
  };

  /// Variação (%) dos novos cadastros em relação ao período anterior.
  static const Map<RegistrationPeriod, String> registrationTrend = {
    RegistrationPeriod.dia: '+5,1% vs. ontem',
    RegistrationPeriod.semana: '+8,3% vs. semana anterior',
    RegistrationPeriod.mes: '+3,2% vs. mês anterior',
    RegistrationPeriod.ano: '+18,7% vs. ano anterior',
  };

  /// Distribuição da origem dos acessos que geraram cadastro.
  static const List<AccessOrigin> accessOrigins = [
    AccessOrigin(label: 'WhatsApp', percent: 58),
    AccessOrigin(label: 'App', percent: 27),
    AccessOrigin(label: 'Web', percent: 15),
  ];
}
