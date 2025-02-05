import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_pay/features/home/presentation/providers/clientes_provider.dart';
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';

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
    final clientesProvider = Provider.of<ClientesProvider>(context);

    return clientesProvider.isLoading
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  itemCount: clientesProvider.clientes.length,
                  separatorBuilder: (_, __) => const Divider(height: 8),
                  itemBuilder: (context, index) {
                    final cliente = clientesProvider.clientes[index];
                    return _buildClienteCard(cliente);
                  },
                ),
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
          // Acción al tocar un cliente (ej. ver detalles)
        },
      ),
    );
  }
}
