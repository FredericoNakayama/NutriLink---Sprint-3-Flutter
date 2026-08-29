/// Rede à qual um banco de leite pertence.
enum MilkBankNetwork { lactare, rblh }

extension MilkBankNetworkLabel on MilkBankNetwork {
  String get label {
    switch (this) {
      case MilkBankNetwork.lactare:
        return 'Lactare';
      case MilkBankNetwork.rblh:
        return 'rBLH';
    }
  }
}

/// Banco de Leite Humano exibido na busca e na tela de detalhes.
class MilkBank {
  final int id;
  final String name;
  final MilkBankNetwork network;
  final String address;
  final String cep;
  final String phone;
  final String hours;
  final bool isOpen;
  final double rating;
  final String distance;

  const MilkBank({
    required this.id,
    required this.name,
    required this.network,
    required this.address,
    required this.cep,
    required this.phone,
    required this.hours,
    required this.isOpen,
    required this.rating,
    required this.distance,
  });
}
