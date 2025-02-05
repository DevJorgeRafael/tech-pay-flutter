import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_pay/features/home/presentation/providers/transacciones_provider.dart';

Widget buildRankingClientes(BuildContext context) {
  final transaccionesProvider = Provider.of<TransaccionesProvider>(context);
  final Map<String, int> ranking = {};

  // Contar transacciones por cliente
  for (var transaccion in transaccionesProvider.transacciones) {
    String cliente = transaccion.cliente.clienteNombre;
    ranking[cliente] = (ranking[cliente] ?? 0) + 1;
  }

  // Ordenar ranking por cantidad de transacciones (de mayor a menor)
  final rankingOrdenado = ranking.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return ListView.builder(
    padding: const EdgeInsets.all(12),
    itemCount: rankingOrdenado.length,
    itemBuilder: (context, index) {
      final entry = rankingOrdenado[index];
      return _buildRankingCard(entry.key, entry.value, index);
    },
  );
}

/// 🎨 Widget Mejorado para cada cliente en el ranking
Widget _buildRankingCard(String cliente, int transacciones, int index) {
  Color colorFondo;
  IconData icono;

  // 🏆 Destacar los primeros 3 lugares
  switch (index) {
    case 0:
      colorFondo = Colors.amber.shade400;
      icono = Icons.emoji_events; // 🏆 Trofeo para el #1
      break;
    case 1:
      colorFondo = Colors.grey.shade400;
      icono = Icons.military_tech; // 🥈 Medalla de plata
      break;
    case 2:
      colorFondo = Colors.brown.shade400;
      icono = Icons.military_tech; // 🥉 Medalla de bronce
      break;
    default:
      colorFondo = Colors.blueGrey.shade50;
      icono = Icons.person; // 👤 Usuario normal
  }

  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 3,
    margin: const EdgeInsets.symmetric(vertical: 6),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: colorFondo.withOpacity(0.8),
        child: Icon(icono, color: Colors.white),
      ),
      title: Text(
        cliente,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        "Transacciones: $transacciones",
        style: const TextStyle(fontSize: 14, color: Colors.black54),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: colorFondo.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "#${index + 1}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ),
    ),
  );
}
