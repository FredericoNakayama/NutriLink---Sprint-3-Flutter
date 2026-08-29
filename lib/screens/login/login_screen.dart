import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../data/mock_users.dart';
import '../../models/user.dart';
import '../../widgets/primary_button.dart';
import '../shell/home_shell.dart';

/// Tela de login — porta de entrada do app e também sua apresentação.
///
/// Valida as credenciais contra os usuários mockados e encaminha o usuário
/// para o [HomeShell] de acordo com o perfil (nutriz ou administrador).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final user = MockUsers.authenticate(
      _emailController.text,
      _passwordController.text,
    );

    if (user == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('E-mail ou senha inválidos. Verifique e tente novamente.'),
            backgroundColor: AppColors.danger,
          ),
        );
      return;
    }

    setState(() => _loading = true);
    // Simula o tempo de autenticação e dá retorno visual à ação.
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeShell(user: user)),
      );
    });
  }

  void _fillCredentials(AppUser user) {
    _emailController.text = user.email;
    _passwordController.text = user.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBrandHeader(context),
              const SizedBox(height: 32),
              Text('Bem-vinda 💙', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 6),
              Text(
                'Acesse sua conta para acompanhar seus agendamentos e '
                'sua jornada de doação de leite humano.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 28),
              _buildForm(),
              const SizedBox(height: 20),
              _buildDemoCredentials(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 26),
        ),
        const SizedBox(width: 12),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w800,
              fontSize: 24,
              color: AppColors.textStrong,
            ),
            children: [
              TextSpan(text: 'Nutri'),
              TextSpan(text: 'Link', style: TextStyle(color: AppColors.primary)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _FieldLabel('E-mail'),
          const SizedBox(height: 6),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'exemplo@nutrilink.com',
              prefixIcon: Icon(Icons.mail_outline, size: 20),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Informe o seu e-mail';
              }
              if (!value.contains('@')) {
                return 'Digite um e-mail válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 18),
          const _FieldLabel('Senha'),
          const SizedBox(height: 6),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              hintText: '••••••••',
              prefixIcon: const Icon(Icons.lock_outline, size: 20),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                  color: AppColors.textSoft,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Informe a sua senha';
              }
              if (value.length < 6) {
                return 'A senha deve ter ao menos 6 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Entrar na minha conta',
            icon: Icons.login,
            loading: _loading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }

  Widget _buildDemoCredentials() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceTint,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, size: 16, color: AppColors.primaryDark),
              const SizedBox(width: 8),
              Text(
                'Contas de demonstração',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _DemoAccountTile(
            title: 'Nutriz',
            subtitle: '${MockUsers.nutriz.email} · senha 123456',
            onTap: () => _fillCredentials(MockUsers.nutriz),
          ),
          const SizedBox(height: 8),
          _DemoAccountTile(
            title: 'Administrador',
            subtitle: '${MockUsers.admin.email} · senha 123456',
            onTap: () => _fillCredentials(MockUsers.admin),
          ),
          const SizedBox(height: 4),
          const Text(
            'Toque em uma conta para preencher os campos.',
            style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: AppColors.textSoft),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: AppColors.textStrong,
      ),
    );
  }
}

class _DemoAccountTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _DemoAccountTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: AppColors.textStrong,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.textSoft),
          ],
        ),
      ),
    );
  }
}
