import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_pay/features/home/presentation/providers/transacciones_provider.dart';
import 'package:tech_pay/features/home/presentation/widgets/build_transaccion_card.dart';

class TransaccionesView extends StatefulWidget {
  const TransaccionesView({super.key});

  @override
  State<TransaccionesView> createState() => _TransaccionesViewState();
}

class _TransaccionesViewState extends State<TransaccionesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransaccionesProvider>(context, listen: false)
          .fetchTransacciones();
    });
  }

  Future<void> _refreshData() async {
    await Provider.of<TransaccionesProvider>(context, listen: false)
        .fetchTransacciones(forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final transaccionesProvider = Provider.of<TransaccionesProvider>(context);

    return Scaffold(
      body: transaccionesProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshData, // 🔄 Pull to Refresh
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: transaccionesProvider.transacciones.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  final transaccion =
                      transaccionesProvider.transacciones[index];
                  return BuildTransaccionCard(transaccion);
                },
              ),
            ),
    );
  }

  
}
