import 'package:flutter/material.dart';
import '../../domain/entities/usuario_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/is_logged_in_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

class AuthProvider with ChangeNotifier {
  final LoginUseCase loginUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;
  final LogoutUseCase logoutUseCase;

  AuthProvider({
    required this.loginUseCase,
    required this.isLoggedInUseCase,
    required this.logoutUseCase,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserEntity? _user;
  UserEntity? get user => _user;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Realiza el login a través del caso de uso
      final user = await loginUseCase(email, password);

      // Actualiza el estado con el usuario autenticado
      _user = user;
      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> isLoggedIn() async {
    final isLogged = await isLoggedInUseCase();
    print('🔵 isLoggedIn desde AuthProvider: $isLogged');
    return isLogged;
  }


  Future<void> loadUser() async {
    final storedUser = await loginUseCase.repository.getStoredUser();
    print('Usuario almacenado desde auth_provider ---------> $storedUser');
    if (storedUser != null) {
      _user = storedUser;
      notifyListeners();
    }
  }


  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await logoutUseCase();
      _user = null;
      await loginUseCase.repository.deleteStoredUser();
      await loginUseCase.repository.deleteToken();
    } catch (e) {
      print('Error en logout: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
