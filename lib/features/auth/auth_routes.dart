import 'package:go_router/go_router.dart';
import 'package:tech_pay/features/auth/presentation/pages/login_page.dart';

class AuthRoutes {
  static final authRoutes = [
    GoRoute(
      path: '/login', 
      builder: (context, state) => const LoginPage()
    ),
  ];
}