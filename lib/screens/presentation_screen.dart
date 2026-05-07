import 'package:flutter/material.dart';

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _dotsController;
  late AnimationController _buttonController;
  late AnimationController _floatingController;

  late Animation<double> _logoFade;
  late Animation<double> _logoScale;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;
  late Animation<double> _buttonFade;
  late Animation<Offset> _buttonSlide;
  late Animation<double> _floatingAnim;

  final int _currentPage = 0;

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

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );
    _logoScale = Tween<double>(begin: 0.7, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );

    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _buttonFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
    );
    _buttonSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
    );

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    _textController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _dotsController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _buttonController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _dotsController.dispose();
    _buttonController.dispose();
    _floatingController.dispose();
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
            child: Column(
              children: [
                const Spacer(flex: 2),
                // Logo
                FadeTransition(
                  opacity: _logoFade,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: AnimatedBuilder(
                      animation: _floatingAnim,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, -_floatingAnim.value),
                          child: child,
                        );
                      },
                      child: _buildLogo(),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Nombre
                FadeTransition(
                  opacity: _textFade,
                ),
                const SizedBox(height: 16),
                // Tagline
                FadeTransition(
                  opacity: _textFade,
                  child: SlideTransition(
                    position: _textSlide,
                    child: const Text(
                      'Tecnología que cuida\na quienes más amas.', // Eslogan
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF5A6E85),
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                // Dots
                FadeTransition(
                  opacity: _dotsController,
                  child: _buildPageDots(),
                ),
                const SizedBox(height: 32),
                // Botón
                FadeTransition(
                  opacity: _buttonFade,
                  child: SlideTransition(
                    position: _buttonSlide,
                    child: _buildButton(),
                  ),
                ),
                const SizedBox(height: 40),
              ],
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
        ..._buildFloatingDots(),
      ],
    );
  }

  List<Widget> _buildFloatingDots() {
    final dots = [
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
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, -_floatingAnim.value * 0.5),
              child: child,
            );
          },
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

  Widget _buildLogo() {
    return Image.asset(
      'assets/logo.png', // 👈 cambia esta ruta
      width: 200,
      height: 180,
    );
  }

  Widget _buildPageDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: isActive ? 22 : 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isActive ? const Color(0xFF1A3E6E) : const Color(0xFFBFCFDE),
          ),
        );
      }),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: ElevatedButton(
          onPressed: () {
            // TODO: navegar a la siguiente pantalla
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A3E6E),
            foregroundColor: Colors.white,
            elevation: 6,
            shadowColor: const Color(0xFF1A3E6E).withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Comenzar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DOT DATA HELPER
// ─────────────────────────────────────────────
class _DotData {
  final double? top, bottom, left, right;
  final double size, opacity;
  const _DotData({
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.size,
    required this.opacity,
  });
}