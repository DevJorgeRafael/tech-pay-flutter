import 'package:flutter/material.dart';
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';

class ClienteApikeysView extends StatelessWidget {
  final ClienteEntity cliente;

  const ClienteApikeysView({super.key, required this.cliente});

  @override
  Widget build(BuildContext context) {
    return cliente.apikeys.isEmpty
        ? const Center(child: Text('No hay API Keys registradas.'))
        : ListView.builder(
            itemCount: cliente.apikeys.length,
            itemBuilder: (context, index) {
              final apikey = cliente.apikeys[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.vpn_key),
                  title: Text(apikey.apikeyDescripcion),
                  subtitle: Text(apikey.apikeyKey),
                  trailing: Switch(
                    value: apikey.apikeyEstado,
                    onChanged: (value) {
                      // TODO: Llamar API para activar/desactivar API Key
                    },
                  ),
                ),
              );
            },
          );
  }
}
