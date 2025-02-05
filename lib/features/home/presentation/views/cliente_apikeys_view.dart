import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';
import 'package:tech_pay/features/home/domain/entities/apikey_entity.dart';
import 'package:tech_pay/features/home/presentation/providers/clientes_provider.dart';

class ClienteApikeysView extends StatefulWidget {
  final ClienteEntity cliente;

  const ClienteApikeysView({super.key, required this.cliente});

  @override
  State<ClienteApikeysView> createState() => _ClienteApikeysViewState();
}

class _ClienteApikeysViewState extends State<ClienteApikeysView> {
  List<ApikeyEntity> apikeys = []; // 🔥 Inicializar aquí para evitar el error

  @override
  void initState() {
    super.initState();
    apikeys = List.from(widget.cliente.apikeys); // Clonamos la lista original
  }

  @override
  Widget build(BuildContext context) {
    return apikeys.isEmpty
        ? const Center(child: Text('No hay API Keys registradas.'))
        : ListView.builder(
            itemCount: apikeys.length,
            itemBuilder: (context, index) {
              final apikey = apikeys[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: Icon(Icons.vpn_key,
                      color: apikey.apikeyEstado ? Colors.green : Colors.grey),
                  title: Text(apikey.apikeyDescripcion),
                  subtitle: Text(apikey.apikeyKey),
                  trailing: Switch(
                    value: apikey.apikeyEstado,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.green,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey[400],
                    onChanged: (value) async {
                      // 🔥 Crear una nueva instancia de ApikeyEntity
                      final updatedApikey = ApikeyEntity(
                        apikeyId: apikey.apikeyId,
                        apikeyKey: apikey.apikeyKey,
                        apikeyDescripcion: apikey.apikeyDescripcion,
                        apikeyEstado: value, // 🔥 Cambiar el estado aquí
                      );

                      // 🔥 Actualizar la lista local para reflejar los cambios en la UI
                      setState(() {
                        apikeys[index] = updatedApikey;
                      });

                      // 🔥 Llamar al provider para hacer el PUT en la API
                      await Provider.of<ClientesProvider>(context,
                              listen: false)
                          .updateApikeyEstado(apikey.apikeyId, value);
                    },
                  ),
                ),
              );
            },
          );
  }
}
