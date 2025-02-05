import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';
import 'package:tech_pay/features/home/presentation/pages/cliente_detalle_page.dart';
import 'package:tech_pay/features/home/presentation/pages/home_page.dart';
import 'package:tech_pay/features/home/presentation/pages/reports_page.dart';

class HomeRoutes {
  static final homeRoutes = [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage()
    ),
    GoRoute(
      path: '/cliente/:clienteId',
      pageBuilder: (context, state) {
        final cliente = state.extra as ClienteEntity;
        return CustomTransitionPage(
          key: state.pageKey,
          child: ClienteDetallePage(cliente: cliente),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Comienza desde la derecha
            const end = Offset.zero; // Termina en su posición normal
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/reports',
      builder: (context, state) {
        final String initialTab = state.extra as String ?? "grafico";
        return ReportsPage(initialTab: initialTab);
      }
    )
  ];
}