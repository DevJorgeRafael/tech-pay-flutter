import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_pay/features/auth/domain/entities/usuario.dart';
import 'package:tech_pay/features/auth/presentation/providers/auth_provider.dart';
import 'package:tech_pay/features/home/presentation/views/api_keys_view.dart';
import 'package:tech_pay/features/home/presentation/views/transacciones_view.dart';
import 'package:tech_pay/injection_container.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authProvider = sl<AuthProvider>();
    final usuario = authProvider.user;
    print('usuario desde home_page ---------> $usuario');

    final views = [
      const TransaccionesView(), 
      const ApiKeysView()
    ];

    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0
            ? const Text('Transacciones')
            : const Text('API Keys'),
      ),
      drawer: _buildDrawer(context, usuario),
      body: views[_selectedIndex],

      floatingActionButton: _selectedIndex == 1 ? _buildFloatingActionButton() : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Transacciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vpn_key),
            label: 'API Keys',
          ),
        ],
        selectedItemColor: Colors.red[500],
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget? _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.red[500],
      child: const Icon(Icons.add),
    );
  }

  Widget _buildDrawer(BuildContext context, Usuario? usuario) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red[500],
            ),
            child: Row(
              children: [
                const Icon(Icons.person, size: 60, color: Colors.white),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      usuario?.usuarioId.toString() ?? '0',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      usuario?.usuarioNombre ?? 'Invitado',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      usuario?.usuarioCorreo ?? 'Sin email',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Configuración'),
                  onTap: () {
                    Navigator.pop(context);
                    // Navegar a configuración (si se implementa)
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar Sesión'),
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
}