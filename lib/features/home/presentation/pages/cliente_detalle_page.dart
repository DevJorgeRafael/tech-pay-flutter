import 'package:flutter/material.dart';
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';
import 'package:tech_pay/features/home/presentation/views/cliente_apikeys_view.dart';
import 'package:tech_pay/features/home/presentation/views/cliente_transacciones_view.dart';

class ClienteDetallePage extends StatefulWidget {
  final ClienteEntity cliente;

  const ClienteDetallePage({super.key, required this.cliente});

  @override
  State<ClienteDetallePage> createState() => _ClienteDetallePageState();
}

class _ClienteDetallePageState extends State<ClienteDetallePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.cliente.clienteNombre,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
            color: Colors.white), // Hace que el botón de retroceso sea blanco
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white, // Color de la línea de selección
          labelColor: Colors.white, // Color del texto de la pestaña activa
          unselectedLabelColor:
              Colors.white70, // Color del texto de las pestañas inactivas
          tabs: const [
            Tab(
                icon: Icon(Icons.vpn_key, color: Colors.white),
                text: 'API Keys'),
            Tab(
                icon: Icon(Icons.payment, color: Colors.white),
                text: 'Transacciones'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ClienteApikeysView(cliente: widget.cliente),
          ClienteTransaccionesView(cliente: widget.cliente),
        ],
      ),
    );
  }
}
