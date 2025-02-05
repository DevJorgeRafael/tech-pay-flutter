

import 'package:flutter/material.dart';
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';
import 'package:tech_pay/features/home/domain/usecases/add_cliente_usecase.dart';
import 'package:tech_pay/features/home/domain/usecases/get_cliente_usecase.dart';
import 'package:tech_pay/features/home/domain/usecases/get_clientes_usecase.dart';
import 'package:tech_pay/features/home/domain/usecases/update_cliente_usecase.dart';

class ClientesProvider with ChangeNotifier {
  final GetClientesUsecase getClientesUsecase;
  final GetClienteUsecase getClienteUsecase;
  final AddClienteUsecase addClienteUsecase;
  final UpdateClienteUsecase updateClienteUsecase;

  ClientesProvider({
    required this.getClientesUsecase,
    required this.getClienteUsecase,
    required this.addClienteUsecase,
    required this.updateClienteUsecase,
  }) {
    print("✅ ClientesProvider inicializado correctamente");
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<ClienteEntity> _clientes = [];
  List<ClienteEntity> get clientes => _clientes;

  Future<void> fetchClientes({bool forceRefresh = false}) async {
    if(_clientes.isNotEmpty && !forceRefresh) return;

    _isLoading = true;
    notifyListeners();

    try {
      _clientes = await getClientesUsecase();
    } catch (e) {
      print('❌ Error al obtener clientes: $e');
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCliente(String clienteNombre) async {
    await addClienteUsecase(clienteNombre);
    await fetchClientes();
  }

  Future<void> updateCliente(int id, String clienteNombre) async {
    await updateClienteUsecase(id, clienteNombre);
    await fetchClientes();
  }
}