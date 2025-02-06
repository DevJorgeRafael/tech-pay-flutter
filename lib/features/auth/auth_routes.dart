import 'package:go_router/go_router.dart';
import 'package:tech_pay/features/auth/presentation/pages/login_page.dart';
import 'package:tech_pay/features/auth/presentation/pages/terminos_condiciones_page.dart';

class AuthRoutes {
  static final authRoutes = [
    GoRoute(
      path: '/login', 
      builder: (context, state) => const LoginPage()
    ),
    GoRoute(path: '/terminos-condiciones', 
      builder: (context, state) => const TerminosCondicionesPage()
    ),
  ];
}