import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tech_pay/features/home/domain/entities/transaccion_entity.dart';

Widget buildTransaccionCard(TransaccionEntity transaccion) {
  final colorEstado =
      _getEstadoColor(transaccion.estadoTransaccion.estadoNombre);
  final iconoEstado =
      _getEstadoIcon(transaccion.estadoTransaccion.estadoNombre);
  final fechaFormateada = DateFormat('dd MMM yyyy', 'es_ES').format(transaccion.transaccionFecha);

  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: ListTile(
      contentPadding: const EdgeInsets.all(15),
      leading: CircleAvatar(
        backgroundColor: colorEstado.withOpacity(0.2),
        child: Icon(iconoEstado, color: colorEstado),
      ),
      title: Text(
        'Monto: ${transaccion.transaccionMonto} ${transaccion.transaccionMoneda}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            transaccion.transaccionDescripcion,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            transaccion.estadoTransaccion.estadoNombre,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: colorEstado,
            ),
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            fechaFormateada,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}

// 🎨 Función para obtener el color del estado
Color _getEstadoColor(String estado) {
  switch (estado.toLowerCase()) {
    case 'transacción aceptada':
      return Colors.green;
    case 'transacción pendiente':
      return Colors.blue;
    case 'transacción rechazada':
      return Colors.red;
    case 'api key inválida':
    case 'datos de tarjeta incorrectos':
      return Colors.orange;
    default:
      return Colors.grey;
  }
}

IconData _getEstadoIcon(String estado) {
  switch (estado.toLowerCase()) {
    case 'transacción aceptada':
      return Icons.check_circle;
    case 'transacción pendiente':
      return Icons.hourglass_empty;
    case 'transacción rechazada':
      return Icons.cancel;
    case 'api key inválida':
    case 'datos de tarjeta incorrectos':
      return Icons.warning;
    default:
      return Icons.help_outline;
  }
}
