import 'package:flutter/material.dart';
import 'home_screen.dart';

class DispositivoScreen extends StatefulWidget {
  const DispositivoScreen({super.key});

  @override
  State<DispositivoScreen> createState() => _DispositivoScreenState();
}

class _DispositivoScreenState extends State<DispositivoScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late AnimationController _spinController;
  late AnimationController _dotsController;

  late Animation<double> _fadeAnim;
  late Animation<double> _pulseAnim;
  late Animation<double> _spinAnim;
  late Animation<double> _dotsAnim;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _spinAnim = Tween<double>(begin: 0, end: 1).animate(_spinController);

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _dotsAnim = CurvedAnimation(parent: _dotsController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    _spinController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          // Back
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Color(0xFF1A3E6E),
                                size: 26,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Título
                          const Text(
                            'Conecta tu\ndispositivo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1A3E6E),
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Asegúrate de que el dispositivo\nesté encendido.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF7A90A8),
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 28),
                          // WiFi icon con pulso
                          _buildWifiIcon(),
                          const SizedBox(height: 10),
                          // Dots verticales
                          _buildVerticalDots(),
                          const SizedBox(height: 10),
                          // Imagen del dispositivo
                          _buildDeviceImage(),
                          const SizedBox(height: 28),
                          // Card de instrucciones
                          _buildInstructionsCard(),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                  // Buscando dispositivo...
                  _buildSearchingBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Background ───────────────────────────────
  Widget _buildBackground() {
    return Stack(
      children: [
        Positioned(
          top: -60,
          right: -80,
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF90B8D8).withOpacity(0.2),
                width: 1.5,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -40,
          left: -50,
          child: Container(
            width: 160,
            height: 160,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD6E8F5),
            ),
          ),
        ),
        // Círculo grande detrás del dispositivo
        Positioned(
          top: 320,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF90B8D8).withOpacity(0.15),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        Positioned(top: 200, left: 24, child: _dot(8, 0.35)),
        Positioned(top: 300, right: 28, child: _dot(10, 0.45)),
        Positioned(top: 380, left: 60, child: _dot(6, 0.25)),
        Positioned(top: 420, right: 55, child: _dot(8, 0.3)),
        Positioned(top: 500, left: 30, child: _dot(6, 0.2)),
      ],
    );
  }

  Widget _dot(double size, double opacity) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF5B9BD5).withOpacity(opacity),
        ),
      );

  // ─── WiFi Icon ────────────────────────────────
  Widget _buildWifiIcon() {
    return ScaleTransition(
      scale: _pulseAnim,
      child: Container(
        width: 72,
        height: 72,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFEBF2FA),
        ),
        child: const Icon(
          Icons.wifi_rounded,
          color: Color(0xFF1A3E6E),
          size: 38,
        ),
      ),
    );
  }

  // ─── Vertical dots ────────────────────────────
  Widget _buildVerticalDots() {
    return Column(
      children: List.generate(3, (i) {
        return AnimatedBuilder(
          animation: _dotsAnim,
          builder: (_, __) {
            final delay = i * 0.3;
            final t = (_dotsAnim.value - delay).clamp(0.0, 1.0);
            return Opacity(
              opacity: 0.3 + t * 0.7,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1A3E6E),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  // ─── Device Image ─────────────────────────────
  Widget _buildDeviceImage() {
    return SizedBox(
      height: 220,
      child: Image.asset(
        'assets/dispositivo.png', // 👈 cambia esta ruta
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            color: const Color(0xFFEBF2FA),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.devices_other_outlined,
            size: 80,
            color: Color(0xFF1A3E6E),
          ),
        ),
      ),
    );
  }

  // ─── Instructions Card ────────────────────────
  Widget _buildInstructionsCard() {
    final items = [
      (Icons.smartphone_outlined, 'Mantén el dispositivo cerca\nde tu teléfono'),
      (Icons.lightbulb_outline_rounded, 'El LED debe parpadear\nen color azul'),
      (Icons.access_time_outlined, 'Esto puede tardar unos\nsegundos'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDDE6EF)),
      ),
      child: Column(
        children: items.asMap().entries.map((e) {
          final idx = e.key;
          final item = e.value;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(item.$1,
                        color: const Color(0xFF1A3E6E), size: 26),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item.$2,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF3A5270),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (idx < items.length - 1)
                const Divider(
                    height: 1, color: Color(0xFFEBF2FA), indent: 20),
            ],
          );
        }).toList(),
      ),
    );
  }
  
  // ─── Searching bar ────────────────────────────
  Widget _buildSearchingBar() {
    return Container(
      color: const Color(0xFFF5F8FC),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotationTransition(
                turns: _spinAnim,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF1A3E6E),
                      width: 2.5,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 5,
                      height: 5,
                      margin: const EdgeInsets.only(top: 1),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF1A3E6E),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              const Text(
                'Buscando dispositivo...',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A3E6E),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A3E6E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Siguiente',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}