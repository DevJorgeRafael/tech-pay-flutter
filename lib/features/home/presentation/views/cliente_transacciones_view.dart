import 'package:flutter/material.dart';
import 'package:tech_pay/features/home/domain/entities/cliente_entity.dart';
import 'package:intl/intl.dart';

class ClienteTransaccionesView extends StatelessWidget {
  final ClienteEntity cliente;

  const ClienteTransaccionesView({super.key, required this.cliente});

  @override
  Widget build(BuildContext context) {
    return cliente.transacciones.isEmpty
        ? const Center(child: Text('No hay transacciones registradas.'))
        : ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
            itemCount: cliente.transacciones.length,
            itemBuilder: (context, index) {
              final transaccion = cliente.transacciones[index];
              final fechaFormateada = DateFormat('dd MMM yyyy')
                  .format(transaccion.transaccionFecha);
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.payment, color: Colors.green),
                  title: Text(
                      'Monto: ${transaccion.transaccionMonto} ${transaccion.transaccionMoneda}'),
                  subtitle: Text(transaccion.transaccionDescripcion),
                  trailing: Text(
                    fechaFormateada,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              );
            },
          );
  }
}
