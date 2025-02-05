import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tech_pay/features/home/presentation/providers/transacciones_provider.dart';

Widget buildFiltroPorFecha(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () async {
        DateTimeRange? pickedRange = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
        );

        if (pickedRange != null) {
          final transaccionesProvider =
              Provider.of<TransaccionesProvider>(context, listen: false);
          final transaccionesFiltradas =
              transaccionesProvider.transacciones.where((t) {
            return t.transaccionFecha.isAfter(pickedRange.start) &&
                t.transaccionFecha.isBefore(pickedRange.end);
          }).toList();

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Transacciones Filtradas"),
                content: SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: transaccionesFiltradas.length,
                    itemBuilder: (context, index) {
                      final transaccion = transaccionesFiltradas[index];
                      return ListTile(
                        title: Text(
                            "${transaccion.transaccionMonto} ${transaccion.transaccionMoneda}"),
                        subtitle: Text(
                            "Fecha: ${DateFormat('dd MMM yyyy', 'es_ES').format(transaccion.transaccionFecha)}"),
                      );
                    },
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cerrar")),
                ],
              );
            },
          );
        }
      },
      child: const Text("Seleccionar Rango de Fechas"),
    ),
  );
}
