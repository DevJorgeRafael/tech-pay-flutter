import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_pay/features/auth/domain/entities/usuario_entity.dart';
import 'package:tech_pay/features/auth/presentation/providers/auth_provider.dart';
import 'package:tech_pay/features/home/presentation/views/clientes_view.dart';
import 'package:tech_pay/features/home/presentation/views/transacciones_view.dart';
import 'package:tech_pay/injection_container.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onNavBarTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = sl<AuthProvider>();
    final usuario = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Transacciones' : 'Clientes', style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.red[500],
        iconTheme: const IconThemeData(color: Colors.white),
        actions: _selectedIndex == 0 ? _buildReportMenu(context): null,
      ),
      drawer: _buildDrawer(context, usuario),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          TransaccionesView(),
          ClientesView(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onNavBarTapped,
        elevation: 5,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list_rounded),
            selectedIcon: Icon(Icons.list_rounded, color: Colors.red),
            label: 'Transacciones',
          ),
          NavigationDestination(
            icon: Icon(Icons.business_rounded),
            selectedIcon: Icon(Icons.business_rounded, color: Colors.red),
            label: 'Clientes',
          ),
        ],
        backgroundColor: Colors.white,
        indicatorColor: Colors.red.withOpacity(0.1),
        surfaceTintColor: Colors.white,
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, UserEntity? usuario) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.red[500]),
            accountName: Text(
              usuario?.usuarioNombre ?? 'Invitado',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(usuario?.userEmail ?? 'Sin email'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50, color: Colors.red),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Cerrar Sesión',
                style: TextStyle(color: Colors.red)),
            onTap: () async {
              await Provider.of<AuthProvider>(context, listen: false).logout();
              context.go('/login');
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  List<Widget> _buildReportMenu(BuildContext context) {
    return [
      PopupMenuButton<String>(
        onSelected: (value) {
          context.push('/reports', extra: value);
        },
        itemBuilder: (context) => [
          const PopupMenuItem(value: 'grafico', child: Text('Gráfico de Estados')),
          const PopupMenuItem(value: 'fecha', child: Text('Filtrar por Fecha')),
          const PopupMenuItem(value: 'ranking', child: Text('Ranking de Clientes'))
        ],
      )
    ];
  }
}
