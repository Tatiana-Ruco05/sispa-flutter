import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _enviado = false;
  bool _cargando = false;

  Future<void> _enviarCorreo() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ingresa tu correo")),
      );
      return;
    }

    setState(() => _cargando = true);

    final resultado = await AuthService.sendPasswordReset(
      correo: _emailController.text,
    );

    setState(() => _cargando = false);

    if (resultado["ok"] == true) {
      setState(() => _enviado = true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resultado["message"])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_reset, size: 80, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                "Recuperar contraseña",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 40),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: _enviado ? _mensajeExito() : _formulario(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formulario() {
    return Column(
      children: [
        const Text(
          "Ingresa tu correo y te enviaremos instrucciones para recuperar tu contraseña.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: "Correo electrónico",
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: _cargando ? null : _enviarCorreo,
            child: _cargando
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Enviar", style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }

  Widget _mensajeExito() {
    return Column(
      children: [
        const Icon(Icons.check_circle, size: 60, color: Colors.green),
        const SizedBox(height: 20),
        const Text(
          "¡Correo enviado!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "Revisa tu bandeja de entrada en ${_emailController.text}",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 30),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Volver al login"),
        ),
      ],
    );
  }
}
