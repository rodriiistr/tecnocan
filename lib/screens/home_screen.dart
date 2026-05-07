import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  int _currentTab = 0;

  late AnimationController _fadeController;
  late AnimationController _progressController;
  late Animation<double> _fadeAnim;
  late Animation<double> _progressAnim;

  final double _progreso = 0.78;
  final int _minActual = 78;
  final int _minMeta = 100;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
    _progressAnim = Tween<double>(begin: 0, end: _progreso).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _progressController.dispose();
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          _buildHeader(),
                          const SizedBox(height: 20),
                          _buildPetCard(),
                          const SizedBox(height: 16),
                          _buildMenuGrid(),
                          const SizedBox(height: 20),
                          _buildActividadDiaria(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  _buildBottomNav(),
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
          bottom: 60,
          right: 10,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF5B9BD5).withOpacity(0.5),
            ),
          ),
        ),
        Positioned(
          top: 180,
          right: 40,
          child: Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF5B9BD5).withOpacity(0.3),
            ),
          ),
        ),
      ],
    );
  }

  // ─── Header ───────────────────────────────────
  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '¡Hola, Andrés! 👋',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A3E6E),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Aquí tienes el resumen\nde hoy.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7A90A8),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1A3E6E).withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: Color(0xFF1A3E6E),
                size: 22,
              ),
            ),
            Positioned(
              top: 8,
              right: 10,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF2A7FE8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─── Pet Card ─────────────────────────────────
  Widget _buildPetCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A3E6E), Color(0xFF2A5F9E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A3E6E).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/logo.png', // 👈 cambia por foto de la mascota
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.pets,
                  size: 44,
                  color: Color(0xFF1A3E6E),
                ),
              ),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre + dropdown
                Row(
                  children: const [
                    Text(
                      'Max',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.keyboard_arrow_down_rounded,
                        color: Colors.white, size: 22),
                  ],
                ),
                const SizedBox(height: 10),
                // Status row
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF4CD964),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'En casa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 1,
                      height: 14,
                      color: Colors.white38,
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.battery_charging_full_rounded,
                        color: Color(0xFF4CD964), size: 16),
                    const SizedBox(width: 4),
                    const Text(
                      '100%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Menu Grid ────────────────────────────────
  Widget _buildMenuGrid() {
    final items = [
      (Icons.bar_chart_rounded, 'Actividad'),
      (Icons.location_on_outlined, 'Ubicación'),
      (Icons.favorite_border_rounded, 'Salud'),
      (Icons.settings_outlined, 'Ajustes'),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: items.map((item) => _buildMenuCard(item.$1, item.$2)).toList(),
    );
  }

  Widget _buildMenuCard(IconData icon, String label) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A3E6E).withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF1A3E6E), size: 32),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A3E6E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Actividad Diaria ─────────────────────────
  Widget _buildActividadDiaria() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A3E6E).withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Actividad diaria',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A3E6E),
                ),
              ),
              Row(
                children: const [
                  Text(
                    'Hoy',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF7A90A8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF7A90A8), size: 18),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Content
          Row(
            children: [
              // Circular progress
              AnimatedBuilder(
                animation: _progressAnim,
                builder: (_, __) {
                  return SizedBox(
                    width: 90,
                    height: 90,
                    child: CustomPaint(
                      painter: _CircularProgressPainter(_progressAnim.value),
                      child: Center(
                        child: Text(
                          '${(_progressAnim.value * 100).toInt()}%',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A3E6E),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 20),
              // Meta
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Meta diaria',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF7A90A8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$_minActual / $_minMeta min',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A3E6E),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Mini bar chart
              _buildMiniBarChart(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniBarChart() {
    final bars = [0.5, 0.7, 0.4, 0.6, 0.3, 0.8, 1.0];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: bars.map((h) {
        final isLast = h == 1.0;
        return Container(
          margin: const EdgeInsets.only(left: 4),
          width: 8,
          height: 50 * h,
          decoration: BoxDecoration(
            color: isLast
                ? const Color(0xFF1A3E6E)
                : const Color(0xFF1A3E6E).withOpacity(0.25),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }).toList(),
    );
  }

  // ─── Bottom Nav ───────────────────────────────
  Widget _buildBottomNav() {
    final tabs = [
      (Icons.home_rounded, Icons.home_outlined, 'Inicio'),
      (Icons.pets, Icons.pets_outlined, 'Mascotas'),
      (Icons.shield_rounded, Icons.shield_outlined, 'Seguridad'),
      (Icons.person_rounded, Icons.person_outlined, 'Perfil'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A3E6E).withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tabs.asMap().entries.map((e) {
              final i = e.key;
              final tab = e.value;
              final isActive = _currentTab == i;
              return GestureDetector(
                onTap: () => setState(() => _currentTab = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF1A3E6E)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isActive ? tab.$1 : tab.$2,
                        color: isActive
                            ? Colors.white
                            : const Color(0xFF7A90A8),
                        size: 22,
                      ),
                      if (isActive) ...[
                        const SizedBox(height: 4),
                        Text(
                          tab.$3,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CIRCULAR PROGRESS PAINTER
// ─────────────────────────────────────────────
class _CircularProgressPainter extends CustomPainter {
  final double progress;
  _CircularProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    const strokeWidth = 8.0;

    // Track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = const Color(0xFFE8F0F8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );

    // Progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      Paint()
        ..color = const Color(0xFF1A3E6E)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter old) => old.progress != progress;
}