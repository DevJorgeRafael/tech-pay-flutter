

import 'package:flutter/material.dart';
import 'package:tech_pay/features/home/domain/entities/apikey_entity.dart';
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';
import 'package:tech_pay/features/home/domain/repositories/cliente_repository.dart';
import 'package:tech_pay/features/home/domain/usecases/add_cliente_usecase.dart';
import 'package:tech_pay/features/home/domain/usecases/get_cliente_usecase.dart';
import 'package:tech_pay/features/home/domain/usecases/get_clientes_usecase.dart';
import 'package:tech_pay/features/home/domain/usecases/update_cliente_usecase.dart';

class ClientesProvider with ChangeNotifier {
  final ClienteRepository clienteRepository;
  final GetClientesUsecase getClientesUsecase;
  final GetClienteUsecase getClienteUsecase;
  final AddClienteUsecase addClienteUsecase;
  final UpdateClienteUsecase updateClienteUsecase;

  ClientesProvider({
    required this.clienteRepository,
    required this.getClientesUsecase,
    required this.getClienteUsecase,
    required this.addClienteUsecase,
    required this.updateClienteUsecase,
  });

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<ClienteEntity> _clientes = [];
  List<ClienteEntity> get clientes => _clientes;

  List<ApikeyEntity> _apikeys = [];
  List<ApikeyEntity> get apikeys => _apikeys;

  Future<void> fetchClientes({bool forceRefresh = false}) async {
    if(_clientes.isNotEmpty && !forceRefresh) return;

    _isLoading = true;
    notifyListeners();

    try {
      _clientes = await getClientesUsecase();
    } catch (e) {
      print('❌ Error al obtener clientes: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

 Future<void> addCliente(String clienteNombre) async {
    try {
      final nuevoCliente = await addClienteUsecase(clienteNombre);

      // 🔥 Agregar el nuevo cliente a la lista local sin esperar un nuevo fetch
      _clientes.insert(0, nuevoCliente);

      notifyListeners(); // 🔥 Notificar a la UI inmediatamente
    } catch (e) {
      print('❌ Error al agregar cliente: $e');
    }
  }


  Future<void> updateCliente(int id, String clienteNombre) async {
    await updateClienteUsecase(id, clienteNombre);
    await fetchClientes();
  }

  Future<void> addApiKey(String clienteId, String descripcion) async {
    try {
      final nuevaApikey = await clienteRepository.addApikey(clienteId, descripcion);
      _apikeys.add(nuevaApikey);

  
      final clienteIndex = _clientes.indexWhere((c) => c.clienteId == clienteId);
      if (clienteIndex != -1) {
        _clientes[clienteIndex].apikeys.add(nuevaApikey);
      }

      notifyListeners();
    } catch (e) {
      print('❌ Error al agregar apikey: $e');
    }
  }

  Future<void> updateApikeyEstado(String apiKeyId, bool nuevoEstado) async {
    try {
      await clienteRepository.updateApikeyEstado(apiKeyId, nuevoEstado);

      // 🔥 Buscar la API Key en la lista de clientes y actualizar su estado
      for (var cliente in _clientes) {
        final apikeyIndex =
            cliente.apikeys.indexWhere((a) => a.apikeyId == apiKeyId);
        if (apikeyIndex != -1) {
          cliente.apikeys[apikeyIndex] = ApikeyEntity(
            apikeyId: cliente.apikeys[apikeyIndex].apikeyId,
            apikeyDescripcion: cliente.apikeys[apikeyIndex].apikeyDescripcion,
            apikeyKey: cliente.apikeys[apikeyIndex].apikeyKey,
            apikeyEstado: nuevoEstado, // 🔥 Cambia solo el estado
          );
          break;
        }
      }

      notifyListeners(); // 🔥 Ahora notificamos cambios sin recargar todo
    } catch (e) {
      print('❌ Error al actualizar estado de API Key: $e');
    }
  }

}