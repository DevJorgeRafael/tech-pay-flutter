// 📌 Ranking de clientes
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_pay/features/home/presentation/providers/transacciones_provider.dart';

Widget buildRankingClientes(BuildContext context) {
  final transaccionesProvider = Provider.of<TransaccionesProvider>(context);
  final Map<String, int> ranking = {};

  for (var transaccion in transaccionesProvider.transacciones) {
    String cliente = transaccion.cliente.clienteNombre;
    ranking[cliente] = (ranking[cliente] ?? 0) + 1;
  }

  final rankingOrdenado = ranking.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return ListView.builder(
    padding: const EdgeInsets.all(12),
    itemCount: rankingOrdenado.length,
    itemBuilder: (context, index) {
      final entry = rankingOrdenado[index];
      return ListTile(
        title: Text(entry.key),
        trailing: Text("${entry.value} transacciones"),
      );
    },
  );
}
