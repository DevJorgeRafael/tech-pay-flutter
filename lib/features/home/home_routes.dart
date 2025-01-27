import 'package:go_router/go_router.dart';
import 'package:tech_pay/features/home/presentation/pages/home_page.dart';

class HomeRoutes {
  static final homeRoutes = [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage()
    )
  ];
}