import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;

import 'package:tecnocan/data/app_database.dart';
import 'package:tecnocan/data/database_provider.dart';
import 'package:tecnocan/screens/login_screen.dart';
import 'package:tecnocan/screens/mascota_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nombreController = TextEditingController();
  final _apellidoPController = TextEditingController();
  final _apellidoMController = TextEditingController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _error;

  static const Color _navy = Color(0xFF1A3E6E);
  static const Color _bg = Color(0xFFF5F8FC);

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoPController.dispose();
    _apellidoMController.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Future<void> _register() async {
    FocusScope.of(context).unfocus();

    final nombre = _nombreController.text.trim();
    final apellidoP = _apellidoPController.text.trim();
    final apellidoM = _apellidoMController.text.trim();

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (nombre.isEmpty ||
        apellidoP.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      setState(() {
        _error = 'Completa todos los campos';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final db = DatabaseProvider.of(context);

      final existingUser = await db.getUserByEmail(email);

      if (existingUser != null) {
        setState(() {
          _isLoading = false;
          _error = 'Ese correo ya está registrado';
        });
        return;
      }

      final userId = await db.createUser(
        UsersCompanion.insert(
          nombre: nombre,
          apellidoPaterno: apellidoP,
          apellidoMaterno: Value(apellidoM),
          email: email,
          password: password,
          createdAt: Value(
            DateTime.now().millisecondsSinceEpoch,
          ),
        ),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MascotaScreen(userId: userId),
        ),
      );
    } catch (e) {
      print(e);

      setState(() {
        _error = e.toString();
      });
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 130,
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                'Crear cuenta',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: _navy,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Registra tus datos para continuar',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF6B7A90),
                ),
              ),

              const SizedBox(height: 34),

              // ─── NOMBRE ─────────────────────────────
              _label('Nombre'),
              _field(
                controller: _nombreController,
                hint: 'Rodrigo',
                icon: Icons.person_outline_rounded,
              ),

              const SizedBox(height: 18),

              // ─── APELLIDO PATERNO ──────────────────
              _label('Apellido paterno'),
              _field(
                controller: _apellidoPController,
                hint: 'González',
                icon: Icons.badge_outlined,
              ),

              const SizedBox(height: 18),

              // ─── APELLIDO MATERNO ──────────────────
              _label('Apellido materno'),
              _field(
                controller: _apellidoMController,
                hint: 'López',
                icon: Icons.badge_outlined,
              ),

              const SizedBox(height: 18),

              // ─── CORREO ────────────────────────────
              _label('Correo'),
              _field(
                controller: _emailController,
                hint: 'correo@ejemplo.com',
                icon: Icons.email_outlined,
                keyboard: TextInputType.emailAddress,
              ),

              const SizedBox(height: 18),

              // ─── PASSWORD ──────────────────────────
              _label('Contraseña'),
              _field(
                controller: _passwordController,
                hint: '••••••••',
                icon: Icons.lock_outline_rounded,
                obscure: _obscurePassword,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword =
                          !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFF6B7A90),
                  ),
                ),
              ),

              if (_error != null) ...[
                const SizedBox(height: 16),
                Text(
                  _error!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed:
                      _isLoading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _navy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child:
                              CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Crear cuenta',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 28),

              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const LoginScreen(),
                      ),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: '¿Ya tienes cuenta? ',
                      style: TextStyle(
                        color: Color(0xFF6B7A90),
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: 'Inicia sesión',
                          style: TextStyle(
                            color: _navy,
                            fontWeight:
                                FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: _navy,
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboard =
        TextInputType.text,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF6B7A90),
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xFFD9E3EE),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: _navy,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}