import '../models/dashboard_stats.dart';

/// Dados mockados do dashboard do administrador.
class MockDashboard {
  MockDashboard._();

  static const List<DashboardMetric> metrics = [
    DashboardMetric(label: 'Doadoras ativas', value: '48.210', trend: '+3,2% no mês'),
    DashboardMetric(label: 'Coletas neste mês', value: '1.847', trend: '+8,1% vs. anterior'),
    DashboardMetric(label: 'Bancos parceiros', value: '250', trend: '27 estados'),
    DashboardMetric(label: 'Bebês beneficiados', value: '2.3 mi', trend: 'desde 2020'),
  ];

  static const List<RecentDonation> recentDonations = [
    RecentDonation(
      donorName: 'Ana Maria Ribeiro',
      bankName: 'BLH Lactare — Pinheiros',
      date: '10/09/2026',
      statusLabel: 'Confirmada',
    ),
    RecentDonation(
      donorName: 'Fernanda Costa',
      bankName: 'BLH Hospital das Clínicas',
      date: '09/09/2026',
      statusLabel: 'Em Andamento',
    ),
    RecentDonation(
      donorName: 'Juliana Prado',
      bankName: 'BLH Lactare — Moema',
      date: '08/09/2026',
      statusLabel: 'Confirmada',
    ),
    RecentDonation(
      donorName: 'Mariana Alves',
      bankName: 'BLH Santa Casa de São Paulo',
      date: '08/09/2026',
      statusLabel: 'Pendente',
    ),
    RecentDonation(
      donorName: 'Patrícia Nogueira',
      bankName: 'BLH Maternidade Pro Matre',
      date: '07/09/2026',
      statusLabel: 'Confirmada',
    ),
  ];
}
