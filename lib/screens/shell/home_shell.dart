import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/user.dart';
import '../banks/banks_list_screen.dart';
import '../contents/contents_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../appointment/my_appointment_screen.dart';
import '../login/login_screen.dart';

/// Descreve uma aba da navegação principal.
class _ShellTab {
  final String title;
  final IconData icon;
  final Widget body;

  const _ShellTab({required this.title, required this.icon, required this.body});
}

/// Casca da aplicação após o login.
///
/// Monta a [BottomNavigationBar] com as abas disponíveis para o perfil do
/// usuário: a nutriz vê Conteúdos, Buscar Bancos e Meu Agendamento; o
/// administrador vê, adicionalmente, o Dashboard.
class HomeShell extends StatefulWidget {
  final AppUser user;

  const HomeShell({super.key, required this.user});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  late final List<_ShellTab> _tabs = _buildTabs();

  List<_ShellTab> _buildTabs() {
    return [
      const _ShellTab(
        title: 'Conteúdos',
        icon: Icons.menu_book_rounded,
        body: ContentsScreen(),
      ),
      const _ShellTab(
        title: 'Buscar Bancos',
        icon: Icons.location_on_outlined,
        body: BanksListScreen(),
      ),
      const _ShellTab(
        title: 'Meu Agendamento',
        icon: Icons.event_available_outlined,
        body: MyAppointmentScreen(),
      ),
      if (widget.user.isAdmin)
        const _ShellTab(
          title: 'Dashboard',
          icon: Icons.bar_chart_rounded,
          body: DashboardScreen(),
        ),
    ];
  }

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final tab = _tabs[_index];

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: _UserGreeting(user: widget.user, screenTitle: tab.title),
        actions: [
          IconButton(
            tooltip: 'Sair',
            onPressed: _logout,
            icon: const Icon(Icons.logout, color: AppColors.textMuted, size: 20),
          ),
          const SizedBox(width: 4),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: IndexedStack(
        index: _index,
        children: [for (final t in _tabs) t.body],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          for (final t in _tabs)
            BottomNavigationBarItem(icon: Icon(t.icon), label: t.title),
        ],
      ),
    );
  }
}

class _UserGreeting extends StatelessWidget {
  final AppUser user;
  final String screenTitle;

  const _UserGreeting({required this.user, required this.screenTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 38,
          width: 38,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryLight, AppColors.primary],
            ),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            user.initials,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w800,
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                screenTitle,
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                  color: AppColors.textStrong,
                ),
              ),
              Text(
                '${user.roleLabel} · ${user.name.split(' ').first}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
