import 'package:flutter/material.dart';
import 'package:tech_pay/features/auth/presentation/providers/auth_provider.dart';
import 'package:tech_pay/injection_container.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkLoginState(context);
    });

    return const Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // 🔵 Indicador de carga para mejor UX
      ),
    );
  }

  Future<void> _checkLoginState(BuildContext context) async {
    final authProvider = sl<AuthProvider>();

    try {
      await Future.delayed(const Duration(seconds: 1)); // 🔥 Pequeño delay para evitar carga rápida sin datos
      final isLoggedIn = await authProvider.isLoggedIn();
      print('🔍 isLoggedIn desde SplashPage: $isLoggedIn');
      print('👤 Usuario actual en AuthProvider: ${authProvider.user}');

      if (context.mounted) {
        if (isLoggedIn && authProvider.user != null) {
          context.go('/home');
        } else {
          context.go('/login');
        }
      }
    } catch (e) {
      if (context.mounted) {
        context.go('/login');
      }
    }
  }
}
