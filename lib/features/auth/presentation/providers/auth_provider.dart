import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
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

  User? _user;
  User? get user => _user;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await loginUseCase(email, password);
    } catch (e) {
      // Manejo de errores
      print('Error en login: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> isLoggedIn() async {
    _isLoading = true;
    notifyListeners();

    try {
      return await isLoggedInUseCase();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await logoutUseCase();
      _user = null;
    } catch (e) {
      // Manejo de errores
      print('Error en logout: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
