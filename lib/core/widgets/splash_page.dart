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
        child: Text('TechPay')
      ),
    );
  }

  Future<void> _checkLoginState(BuildContext context) async {
    final authProvider = sl<AuthProvider>();

    try {
      final isLoggedIn = await authProvider.isLoggedIn();

      if(context.mounted) {
        if(isLoggedIn){
          context.go('/home');
        } else {
          context.go('/login');
        }
      }
    } catch (e) {
      if(context.mounted) {
        context.go('/login');
      }
    }
  }
}