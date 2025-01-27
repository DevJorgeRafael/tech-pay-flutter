import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_pay/features/auth/presentation/providers/auth_provider.dart';
import 'package:tech_pay/features/auth/presentation/widgets/custom_input.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Asegúrate de liberar los recursos de los controladores al salir de la página
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleLogin(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor, ingrese el correo y la contraseña')),
      );
      return;
    }

    try {
      await authProvider.login(email, password);

      // Si el login es exitoso, navegar a la página principal
      context.go('/home');
    } catch (e) {
      // Mostrar un mensaje de error si falla el login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _Header(),
                _Form(
                  emailController: emailController,
                  passwordController: passwordController,
                  isLoading: authProvider.isLoading,
                  onSubmit: () => handleLogin(context),
                ),
                const _Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 50),
        Text(
          'TechPay',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Inicia sesión para continuar',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}

class _Form extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback onSubmit;

  const _Form({
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo Electrónico',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            isPassword: true,
            textController: passwordController,
          ),
          const SizedBox(height: 20),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.red,
                    shape: const StadiumBorder(),
                  ),
                  child: const SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: Center(
                        child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
                  ),
                ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(
            fontSize: 14,
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Términos y condiciones de uso',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
