import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../login/login_screen.dart';

/// Tela de abertura do NutriLink.
///
/// Exibe a marca por alguns instantes e encaminha automaticamente para o
/// login.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), _goToLogin);
  }

  void _goToLogin() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 96,
                width: 96,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.white,
                  size: 48,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'NutriLink',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                  fontSize: 34,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Conectando nutrizes e bancos de leite',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 26,
                width: 26,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  valueColor: AlwaysStoppedAnimation(
                    Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
