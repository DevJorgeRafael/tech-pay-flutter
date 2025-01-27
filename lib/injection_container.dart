import 'package:get_it/get_it.dart';
import 'package:tech_pay/core/theme/app_theme.dart';
import 'package:tech_pay/shared/services/auth_token_service.dart';
import 'package:tech_pay/shared/services/dio_client.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/presentation/providers/auth_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // -------------------- Servicios Compartidos -------------
  sl.registerLazySingleton(() => DioClient.instance);
  sl.registerLazySingleton(() => AuthTokenService());
  sl.registerSingleton<AppTheme>(AppTheme());

  // -------------------- Datasources --------------------
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dio: sl()));

  // -------------------- Repositorios --------------------
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()));

  // -------------------- Casos de Uso --------------------
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => IsLoggedInUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  // -------------------- Providers -----------------------
  sl.registerFactory(() => AuthProvider(
        loginUseCase: sl(),
        isLoggedInUseCase: sl(),
        logoutUseCase: sl(),
      ));
}
