import 'package:go_router/go_router.dart';
import 'package:tech_pay/core/widgets/splash_page.dart';
import 'package:tech_pay/features/auth/auth_routes.dart';
import 'package:tech_pay/features/home/home_routes.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage()
      ),
      ...AuthRoutes.authRoutes,
      ...HomeRoutes.homeRoutes,
    ]
  );
}