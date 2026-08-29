import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/mock_banks.dart';
import '../../models/milk_bank.dart';
import '../../widgets/bank_card.dart';
import 'bank_detail_screen.dart';

/// Aba "Buscar Bancos": lista os bancos de leite com busca e filtro por rede.
///
/// Ao tocar em um item, navega para a tela de detalhes passando o objeto
/// [MilkBank] correspondente.
class BanksListScreen extends StatefulWidget {
  const BanksListScreen({super.key});

  @override
  State<BanksListScreen> createState() => _BanksListScreenState();
}

class _BanksListScreenState extends State<BanksListScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  MilkBankNetwork? _networkFilter;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MilkBank> get _filtered {
    return MockBanks.all.where((bank) {
      final matchesQuery = _query.isEmpty ||
          bank.name.toLowerCase().contains(_query.toLowerCase()) ||
          bank.address.toLowerCase().contains(_query.toLowerCase());
      final matchesNetwork =
          _networkFilter == null || bank.network == _networkFilter;
      return matchesQuery && matchesNetwork;
    }).toList();
  }

  void _openDetail(MilkBank bank) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => BankDetailScreen(bank: bank)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final banks = _filtered;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                decoration: InputDecoration(
                  hintText: 'Buscar por nome ou endereço...',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _NetworkChip(
                    label: 'Todos',
                    selected: _networkFilter == null,
                    onTap: () => setState(() => _networkFilter = null),
                  ),
                  const SizedBox(width: 8),
                  _NetworkChip(
                    label: 'Lactare',
                    selected: _networkFilter == MilkBankNetwork.lactare,
                    color: AppColors.primary,
                    onTap: () => setState(
                        () => _networkFilter = MilkBankNetwork.lactare),
                  ),
                  const SizedBox(width: 8),
                  _NetworkChip(
                    label: 'rBLH',
                    selected: _networkFilter == MilkBankNetwork.rblh,
                    color: AppColors.secondary,
                    onTap: () =>
                        setState(() => _networkFilter = MilkBankNetwork.rblh),
                  ),
                  const Spacer(),
                  Text(
                    '${banks.length} banco${banks.length == 1 ? '' : 's'}',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: banks.isEmpty
              ? const _EmptyState()
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: banks.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (_, i) => BankCard(
                    bank: banks[i],
                    onTap: () => _openDetail(banks[i]),
                  ),
                ),
        ),
      ],
    );
  }
}

class _NetworkChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _NetworkChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? color : AppColors.surface,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: selected ? color : AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: selected ? Colors.white : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_off_outlined, size: 48, color: AppColors.border),
          const SizedBox(height: 12),
          Text(
            'Nenhum banco encontrado com esses filtros.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
