import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import 'package:tecnocan/data/app_database.dart';
import 'package:tecnocan/data/database_provider.dart';
import 'home_screen.dart';

// Conexión
import 'package:tecnocan/services/device_discovery.dart';


class DispositivoScreen extends StatefulWidget {
  final int petId;

  const DispositivoScreen({
    super.key,
    required this.petId,
  });

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

  bool _isLoading = false;

  static const Color _navy = Color(0xFF1A3E6E);

  final DeviceDiscovery discovery = DeviceDiscovery();

  String? _deviceIp;
  bool _isSearchingDevice = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      buscarDispositivo();

  });

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _fadeAnim = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _spinAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_spinController);

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _dotsAnim = CurvedAnimation(
      parent: _dotsController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    _spinController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  Future<void> buscarDispositivo() async {
    setState(() {
      _isSearchingDevice = true;
    });

    try {
      // 🔥 aquí buscas el ESP32 en red local (AP)
      final ip = await discovery.findEsp32();

      if (!mounted) return;

      setState(() {
        _deviceIp = ip ?? '192.168.4.1'; // fallback típico ESP32 AP
        _isSearchingDevice = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ip != null
                ? "TecnoCan encontrado en $ip"
                : "Usando conexión directa 192.168.4.1",
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _deviceIp = '192.168.4.1';
        _isSearchingDevice = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Conexión AP activa (default)")),
      );
    }
  }

  Future<void> _guardarYContinuar() async {
    setState(() => _isLoading = true);

    final db = DatabaseProvider.of(context);

    if (_deviceIp == null) {
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay dispositivo conectado'),
        ),
      );
      return;
    }

    await db.saveDevice(
      DevicesCompanion.insert(
        petId: widget.petId,
        macAddress: _deviceIp!, // 👈 aquí va IP del ESP32 AP
        nickname: const Value('Mi TecnoCan'),
        connectedAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );

    final pet = await db.getPetById(widget.petId);

    if (!mounted) return;

    setState(() => _isLoading = false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(userId: pet!.userId),
      ),
    );
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

                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.arrow_back,
                                color: _navy,
                                size: 26,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          const Text(
                            'Conecta tu\ndispositivo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: _navy,
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

                          _buildWifiIcon(),

                          const SizedBox(height: 10),

                          _buildVerticalDots(),

                          const SizedBox(height: 10),

                          _buildDeviceImage(),

                          const SizedBox(height: 28),

                          _buildInstructionsCard(),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),

                  _buildSearchingBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _dot(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF5B9BD5).withOpacity(opacity),
      ),
    );
  }

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
          color: _navy,
          size: 38,
        ),
      ),
    );
  }

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
                  color: _navy,
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildDeviceImage() {
    return SizedBox(
      height: 220,
      child: Image.asset(
        'assets/dispositivo.png',
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) {
          return Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              color: const Color(0xFFEBF2FA),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.devices_other_outlined,
              size: 80,
              color: _navy,
            ),
          );
        },
      ),
    );
  }

  Widget _buildInstructionsCard() {
    final items = [
      (
        Icons.smartphone_outlined,
        'Mantén el dispositivo cerca\nde tu teléfono',
      ),
      (
        Icons.lightbulb_outline_rounded,
        'El LED debe parpadear\nen color azul',
      ),
      (
        Icons.access_time_outlined,
        'Esto puede tardar unos\nsegundos',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDDE6EF),
        ),
      ),
      child: Column(
        children: items.asMap().entries.map((e) {
          final idx = e.key;
          final item = e.value;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      item.$1,
                      color: _navy,
                      size: 26,
                    ),

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
                  height: 1,
                  color: Color(0xFFEBF2FA),
                  indent: 20,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

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
                      color: _navy,
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
                        color: _navy,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Text(
                _isSearchingDevice
                    ? 'Buscando dispositivo...'
                    : _deviceIp != null
                        ? 'Dispositivo conectado'
                        : 'No encontrado',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: _navy,
                ),
              )
            ],
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _guardarYContinuar,
              style: ElevatedButton.styleFrom(
                backgroundColor: _navy,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
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