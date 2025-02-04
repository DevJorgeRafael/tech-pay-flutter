import 'package:flutter/material.dart';
import 'package:tech_pay/features/home/domain/entities/transaccion_entity.dart';
import 'package:tech_pay/features/home/domain/usecases/get_transacciones_usecase.dart';

class TransaccionesProvider with ChangeNotifier {
  final GetTransaccionesUseCase getTransaccionesUseCase;

  TransaccionesProvider({required this.getTransaccionesUseCase});

  List<TransaccionEntity> _transacciones = [];
  bool _isLoading = false;

  List<TransaccionEntity> get transacciones => _transacciones;
  bool get isLoading => _isLoading;

  Future<void> fetchTransacciones({bool forceRefresh = false}) async {
    if(_transacciones.isNotEmpty && !forceRefresh) return;

    _isLoading = true;
    notifyListeners();

    try {
      _transacciones = await getTransaccionesUseCase();
    } catch (e) {
      print('❌ Error al obtener transacciones: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
