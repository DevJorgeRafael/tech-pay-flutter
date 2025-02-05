import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_pay/features/home/presentation/providers/transacciones_provider.dart';

Widget buildGraficoEstadosPastel(BuildContext context) {
  final transaccionesProvider = Provider.of<TransaccionesProvider>(context);
  final transacciones = transaccionesProvider.transacciones;

  // Contar la cantidad de transacciones por estado
  final int aprobadas = transacciones
      .where((t) =>
          t.estadoTransaccion.estadoNombre.toLowerCase() ==
          "transacción aceptada")
      .length;

  final int pendientes = transacciones
      .where((t) =>
          t.estadoTransaccion.estadoNombre.toLowerCase() ==
          "transacción pendiente")
      .length;

  // 🚀 Si NO es Aceptada y NO es Pendiente, entonces es Rechazada
  final int rechazadas = transacciones.length - (aprobadas + pendientes);

  // Calcular el total de transacciones
  final total = aprobadas + pendientes + rechazadas;

  // Si no hay transacciones, mostrar mensaje
  if (total == 0) {
    return const Center(
      child: Text(
        "No hay transacciones disponibles",
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }

  return Column(
    crossAxisAlignment:
        CrossAxisAlignment.center, 
    children: [
      SizedBox(
        height: 300, // Ajustar el tamaño del gráfico
        child: Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              PieChartData(
                centerSpaceRadius: 80, // Espacio amplio en el centro
                sectionsSpace: 2, // Espacio entre las secciones
                sections: [
                  _buildSection("transacción aceptada", aprobadas, total),
                  _buildSection("transacción pendiente", pendientes, total),
                  _buildSection("transacción rechazada", rechazadas, total),
                ].whereType<PieChartSectionData>().toList(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "$total",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildLegend("Aprobadas", Colors.green[400]!, aprobadas),
            _buildLegend("Pendientes", Colors.blue[400]!, pendientes),
            _buildLegend("Rechazadas", Colors.red[400]!, rechazadas),
          ],
        ),
      ),
    ],
  );

}

/// 🔹 Sección individual del gráfico
PieChartSectionData? _buildSection(String estado, int count, int total) {
  if (count == 0) return null; // Evitar agregar secciones vacías

  return PieChartSectionData(
    color: _getEstadoColor(estado),
    value: (count / total) * 100,
    title: '${(count / total * 100).toStringAsFixed(1)}%',
    radius: 50,
    titleStyle: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
  );
}

/// 🎨 Widget de la leyenda (explicación de colores)
Widget _buildLegend(String label, Color color, int count) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "$label: $count",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

/// 🎨 Función para obtener colores por estado
Color _getEstadoColor(String estado) {
  switch (estado.toLowerCase()) {
    case 'transacción aceptada':
      return Colors.green[400]!;
    case 'transacción pendiente':
      return Colors.blue[400]!;
    case 'transacción rechazada': // Rechazadas ahora incluyen TODO lo que no es Aprobado ni Pendiente
      return Colors.red[400]!;
    default:
      return Colors.grey;
  }
}
