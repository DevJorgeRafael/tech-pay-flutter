import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_pay/features/home/data/models/cliente_model.dart';
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';
import 'package:tech_pay/features/home/presentation/providers/clientes_provider.dart';

class ClienteApikeysView extends StatelessWidget {
  final ClienteEntity cliente;

  const ClienteApikeysView({super.key, required this.cliente});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientesProvider>(
      builder: (context, clientesProvider, child) {
        final clienteActualizado = clientesProvider.clientes.firstWhere(
          (c) => c.clienteId == cliente.clienteId,
          orElse: () => ClienteModel(
            clienteId: cliente.clienteId,
            clienteNombre: cliente.clienteNombre,
            apikeys: cliente.apikeys,
            transacciones: cliente.transacciones,
          ),
        );

        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: clientesProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : clienteActualizado.apikeys.isEmpty
                      ? const Center(
                          child: Text('No hay API Keys registradas.'))
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 80),
                          itemCount: clienteActualizado.apikeys.length,
                          itemBuilder: (context, index) {
                            final apikey = clienteActualizado.apikeys[index];

                            return Card(
                              margin: const EdgeInsets.all(10),
                              child: ListTile(
                                leading: Icon(Icons.vpn_key,
                                    color: apikey.apikeyEstado
                                        ? Colors.green
                                        : Colors.grey),
                                title: Text(apikey.apikeyDescripcion),
                                subtitle: Text(apikey.apikeyKey),
                                trailing: Switch(
                                  value: apikey.apikeyEstado,
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.green,
                                  inactiveThumbColor: Colors.white,
                                  inactiveTrackColor: Colors.grey[400],
                                  onChanged: (value) async {
                                    await clientesProvider.updateApikeyEstado(
                                        apikey.apikeyId, value);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
            ),
            // 🔥 Floating Action Button Posicionado Correctamente
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton.extended(
                onPressed: () => _mostrarDialogCrearApiKey(context),
                backgroundColor: Colors.redAccent,
                icon: const Icon(Icons.add_rounded),
                label: const Text("Nueva API Key"),
              ),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogCrearApiKey(BuildContext context) {
    final TextEditingController descripcionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Nueva API Key"),
          content: TextField(
            controller: descripcionController,
            decoration: const InputDecoration(
              labelText: "Descripción",
              hintText: "Ejemplo: Acceso a datos de clientes",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                final descripcion = descripcionController.text.trim();
                if (descripcion.isNotEmpty) {
                  await Provider.of<ClientesProvider>(context, listen: false)
                      .addApiKey(cliente.clienteId, descripcion);
                  Navigator.pop(context);
                }
              },
              child: const Text("Crear"),
            ),
          ],
        );
      },
    );
  }
}
