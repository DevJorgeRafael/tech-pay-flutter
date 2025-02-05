import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_pay/features/home/presentation/providers/clientes_provider.dart';
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';
import 'package:go_router/go_router.dart';

class ClientesView extends StatefulWidget {
  const ClientesView({super.key});

  @override
  State<ClientesView> createState() => _ClientesViewState();
}

class _ClientesViewState extends State<ClientesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ClientesProvider>(context, listen: false).fetchClientes();
    });
  }

  Future<void> _refreshData() async {
    await Provider.of<ClientesProvider>(context, listen: false)
        .fetchClientes(forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientesProvider>(
      builder: (context, clientesProvider, child) {
        return Stack(
          children: [
            clientesProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : clientesProvider.clientes.isEmpty
                    ? const Center(
                        child: Text(
                          'No hay clientes registrados.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _refreshData,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          itemCount: clientesProvider.clientes.length + 1,
                          separatorBuilder: (_, __) => const Divider(height: 8),
                          itemBuilder: (context, index) {
                            if (index == clientesProvider.clientes.length) {
                              return const SizedBox(height: 80);
                            }

                            final cliente = clientesProvider.clientes[index];
                            return _buildClienteCard(cliente);
                          },
                        ),
                      ),

            // 🔥 Floating Action Button para agregar un nuevo cliente
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton.extended(
                onPressed: () => _mostrarDialogCrearCliente(context),
                backgroundColor: Colors.red[500],
                icon: const Icon(Icons.person_add_alt_1_rounded),
                label: const Text("Nuevo Cliente"),
              ),
            ),
          ],
        );
      },
    );
  }


  Widget _buildClienteCard(ClienteEntity cliente) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.red.withOpacity(0.2),
          child: const Icon(Icons.person, color: Colors.redAccent, size: 28),
        ),
        title: Text(
          cliente.clienteNombre,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          context.push('/cliente/${cliente.clienteId}', extra: cliente);
        },
      ),
    );
  }

  void _mostrarDialogCrearCliente(BuildContext context) {
    final TextEditingController nombreController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Nuevo Cliente"),
          content: TextField(
            controller: nombreController,
            decoration: const InputDecoration(
              labelText: "Nombre del Cliente",
              hintText: "Ejemplo: Empresa XYZ",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                final nombre = nombreController.text.trim();
                if (nombre.isNotEmpty) {
                  final clientesProvider =
                      Provider.of<ClientesProvider>(context, listen: false);

                  await clientesProvider.addCliente(nombre);

                  // 🔥 Forzar la reconstrucción de la UI
                  if (mounted) {
                    setState(() {});
                  }

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
