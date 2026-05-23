import 'package:flutter/material.dart';
import 'package:tecnocan/screens/mascota_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatingController;
  late final Animation<double> _floatingAnim;

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _floatingAnim = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatingController.dispose();
    super.dispose();
  }

  void _goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MascotaScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Evita que el Scaffold haga resize al abrir teclado
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF5F8FC),
      body: Stack(
        children: [
          // ── Fondo fijo (no se mueve con el teclado) ──
          Positioned.fill(child: _buildBackground()),

          // ── Contenido scrollable encima ──
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SingleChildScrollView(
                // padding inferior para que el teclado no tape campos
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),

                    // ── Logo flotante ──
                    Center(
                      child: AnimatedBuilder(
                        animation: _floatingAnim,
                        builder: (context, child) => Transform.translate(
                          offset: Offset(0, -_floatingAnim.value),
                          child: child,
                        ),
                        child: Image.asset('assets/logo.png', width: 160),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── Título ──
                    const Text(
                      '¡Bienvenido\nde nuevo!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A3E6E),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Inicia sesión para continuar',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF5A6E85),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ── Email ──
                    _fieldLabel('Correo electrónico'),
                    const SizedBox(height: 6),
                    _inputField(
                      hint: 'ejemplo@correo.com',
                      icon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 20),

                    // ── Contraseña ──
                    _fieldLabel('Contraseña'),
                    const SizedBox(height: 6),
                    _inputField(
                      hint: '••••••••',
                      icon: Icons.lock_outline,
                      obscure: _obscurePassword,
                      suffix: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xFF5A6E85),
                          size: 20,
                        ),
                        onPressed: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),

                    // ── Olvidé contraseña ──
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(
                            color: Color(0xFF1A3E6E),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ── Botón iniciar sesión ──
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _goToHome,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A3E6E),
                          foregroundColor: Colors.white,
                          elevation: 6,
                          shadowColor:
                              const Color(0xFF1A3E6E).withOpacity(0.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Iniciar sesión',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward_ios_rounded, size: 15),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ── Divider ──
                    Row(
                      children: const [
                        Expanded(child: Divider(color: Color(0xFFBFCFDE))),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'o continúa con',
                            style: TextStyle(
                              color: Color(0xFF5A6E85),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Color(0xFFBFCFDE))),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ── Social buttons ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialButton('assets/login/apple.png'),
                        const SizedBox(width: 20),
                        _socialButton('assets/login/google.png'),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // ── Registro ──
                    Center(
                      child: RichText(
                        text: const TextSpan(
                          text: '¿No tienes cuenta? ',
                          style: TextStyle(color: Color(0xFF5A6E85)),
                          children: [
                            TextSpan(
                              text: 'Regístrate',
                              style: TextStyle(
                                color: Color(0xFF1A3E6E),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Fondo idéntico al de PresentationScreen ───────────────────────────────
  Widget _buildBackground() {
    return Stack(
      children: [
        // Círculo grande arriba derecha
        Positioned(
          top: -60,
          right: -80,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF90B8D8).withOpacity(0.25),
                width: 1.5,
              ),
            ),
          ),
        ),
        // Círculo mediano arriba derecha
        Positioned(
          top: -30,
          right: -50,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF90B8D8).withOpacity(0.15),
                width: 1,
              ),
            ),
          ),
        ),
        // Círculo sólido abajo izquierda
        Positioned(
          bottom: -40,
          left: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD6E8F5),
            ),
          ),
        ),
        // Dots flotantes animados
        ..._buildFloatingDots(),
      ],
    );
  }

  List<Widget> _buildFloatingDots() {
    const dots = [
      _DotData(top: 120, right: 60, size: 10, opacity: 0.5),
      _DotData(top: 200, right: 120, size: 6, opacity: 0.3),
      _DotData(top: 340, left: 30, size: 7, opacity: 0.4),
      _DotData(bottom: 200, right: 50, size: 8, opacity: 0.4),
      _DotData(bottom: 320, left: 60, size: 6, opacity: 0.3),
      _DotData(top: 160, left: 80, size: 20, opacity: 0.7),
    ];

    return dots.map((d) {
      return Positioned(
        top: d.top,
        bottom: d.bottom,
        left: d.left,
        right: d.right,
        child: AnimatedBuilder(
          animation: _floatingAnim,
          builder: (context, child) => Transform.translate(
            offset: Offset(0, -_floatingAnim.value * 0.5),
            child: child,
          ),
          child: Container(
            width: d.size,
            height: d.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF5B9BD5).withOpacity(d.opacity),
            ),
          ),
        ),
      );
    }).toList();
  }

  // ─── Helpers UI ────────────────────────────────────────────────────────────
  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A3E6E),
      ),
    );
  }

  Widget _inputField({
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      obscureText: obscure,
      style: const TextStyle(fontSize: 15, color: Color(0xFF1B2C3A)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFBFCFDE)),
        prefixIcon: Icon(icon, color: const Color(0xFF5A6E85), size: 20),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFBFCFDE), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1A3E6E), width: 1.5),
        ),
      ),
    );
  }

  Widget _socialButton(String asset) {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFBFCFDE), width: 1),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Center(child: Image.asset(asset, width: 28)),
    );
  }
}

// ─── Dot data helper (igual que PresentationScreen) ────────────────────────
class _DotData {
  final double? top, bottom, left, right;
  final double size, opacity;
  const _DotData({
    this.top, this.bottom, this.left, this.right,
    required this.size,
    required this.opacity,
  });
}