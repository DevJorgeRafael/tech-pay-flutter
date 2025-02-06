import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tech_pay/features/home/presentation/providers/transacciones_provider.dart';
import 'package:tech_pay/features/home/presentation/widgets/build_transaccion_card.dart';

class FiltroPorFechaWidget extends StatefulWidget {
  @override
  _FiltroPorFechaWidgetState createState() => _FiltroPorFechaWidgetState();
}

class _FiltroPorFechaWidgetState extends State<FiltroPorFechaWidget> {
  DateTimeRange? _selectedRange;

  // Formato de fecha
  String get _fechaFormateada {
    if (_selectedRange == null) {
      return "Seleccione un rango de fechas";
    }
    return "${DateFormat('dd MMM yyyy', 'es_ES').format(_selectedRange!.start)} - ${DateFormat('dd MMM yyyy', 'es_ES').format(_selectedRange!.end)}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Builder(
          builder: (context) => GestureDetector(
            onTap: () async {
              DateTimeRange? pickedRange = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: Colors.deepPurple,
                      colorScheme:
                          const ColorScheme.light(primary: Colors.deepPurple),
                      buttonTheme: const ButtonThemeData(
                          textTheme: ButtonTextTheme.primary),
                    ),
                    child: child!,
                  );
                },
              );

              if (pickedRange != null) {
                setState(() {
                  _selectedRange = pickedRange;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _fechaFormateada,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const Icon(Icons.calendar_today, color: Colors.deepPurple),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
            height: 10), // Espacio para separar el selector de fechas
        Expanded(
          child: _buildTransaccionesFiltradas(context),
        ),
      ],
    );
  }

  Widget _buildTransaccionesFiltradas(BuildContext context) {
    final transaccionesProvider =
        Provider.of<TransaccionesProvider>(context, listen: false);

    // Evita el error asegurando que _selectedRange no sea null antes de filtrar
    if (_selectedRange == null) {
      return const Center(
        child: Text(
          "Seleccione un rango de fechas",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );
    }

    final transaccionesFiltradas =
        transaccionesProvider.transacciones.where((t) {
      return t.transaccionFecha.isAfter(
              _selectedRange!.start.subtract(const Duration(seconds: 1))) &&
          t.transaccionFecha
              .isBefore(_selectedRange!.end.add(const Duration(seconds: 1)));
    }).toList();

    if (transaccionesFiltradas.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "No hay transacciones en este rango de fechas",
            style: TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: transaccionesFiltradas.length,
      itemBuilder: (context, index) {
        final transaccion = transaccionesFiltradas[index];
        return buildTransaccionCard(transaccion); 
      },
    );
  }
}
