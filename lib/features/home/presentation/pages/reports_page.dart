import 'package:flutter/material.dart';
import 'package:tech_pay/features/home/presentation/widgets/build_filtro_por_fechat.dart';
import 'package:tech_pay/features/home/presentation/widgets/build_grafico_estados_pastel.dart';
import 'package:tech_pay/features/home/presentation/widgets/build_ranking_clientes.dart';

class ReportsPage extends StatefulWidget {
  final String initialTab; 
  const ReportsPage({super.key, required this.initialTab});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // 🔥 Configurar el tab inicial según la opción seleccionada en el menú
    if (widget.initialTab == "grafico") {
      _tabController.index = 0;
    } else if (widget.initialTab == "fecha") {
      _tabController.index = 1;
    } else if (widget.initialTab == "ranking") {
      _tabController.index = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reportes", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red[500],
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.pie_chart), text: "Estados"),
            Tab(icon: Icon(Icons.date_range), text: "Fechas"),
            Tab(icon: Icon(Icons.leaderboard), text: "Ranking"),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildGraficoEstadosPastel(context), 
          buildFiltroPorFecha(context), 
          buildRankingClientes(context),
        ],
      ),
    );
  }

}
