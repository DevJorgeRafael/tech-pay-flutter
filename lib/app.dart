import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_pay/core/routes/app_router.dart';
import 'package:tech_pay/core/theme/app_theme.dart';
import 'package:tech_pay/features/auth/presentation/providers/auth_provider.dart';
import 'package:tech_pay/features/home/presentation/providers/transacciones_provider.dart';
import 'package:tech_pay/injection_container.dart';
import 'package:tech_pay/shared/services/dio_client.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = sl<AppTheme>();

    DioClient.setupInterceptorsWrapper();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => sl<TransaccionesProvider>())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Tech Pay',
        theme: appTheme.getTheme(),
        routerConfig: AppRouter.router,
      )
    );
  }
}