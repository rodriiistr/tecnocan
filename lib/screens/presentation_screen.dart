import 'package:flutter/material.dart';
import 'package:tecnocan/screens/login_screen.dart';

// ─────────────────────────────────────────────
// DATOS DE CADA PÁGINA — agrega, quita o edita aquí
// ─────────────────────────────────────────────
class _PageData {
  final String title;
  final String subtitle;
  final String asset; // ruta en assets/
  const _PageData({
    required this.title,
    required this.subtitle,
    required this.asset,
  });
}

const List<_PageData> _pages = [
  _PageData(
    title: 'Bienvenido a TecnoCan',
    subtitle: 'Tecnología que cuida\na quienes más amas.',
    asset: 'assets/logo.png',
  ),
  _PageData(
    title: 'Monitorea en tiempo real',
    subtitle: 'Sabe siempre dónde\nestá tu mascota.',
    asset: 'assets/logo.png', // cambiar
  ),
  _PageData(
    title: 'Alertas inteligentes',
    subtitle: 'Recibe notificaciones\ncuando más importa.',
    asset: 'assets/logo.png',
  ),
  _PageData(
    title: 'Todo bajo control',
    subtitle: 'Salud, ubicación y rutinas\nen un solo lugar.',
    asset: 'assets/logo.png',
  ),
];

// ─────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────
class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  int _currentPage = 0;

  // Animaciones por página
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _buttonController;
  late AnimationController _floatingController;

  late Animation<double> _logoFade;
  late Animation<double> _logoScale;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;
  late Animation<double> _buttonFade;
  late Animation<Offset> _buttonSlide;
  late Animation<double> _floatingAnim;

  bool get _isLastPage => _currentPage == _pages.length - 1;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _pageController.addListener(_onPageChanged);

    _initAnimationControllers();
    _startAnimations();
  }

  void _initAnimationControllers() {
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
  }

  void _onPageChanged() {
    final page = _pageController.page?.round() ?? 0;
    if (page != _currentPage) {
      setState(() => _currentPage = page);
      _replayAnimations();
    }
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    _textController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    _buttonController.forward();
  }

  Future<void> _replayAnimations() async {
    _logoController.reset();
    _textController.reset();
    _buttonController.reset();
    await _startAnimations();
  }

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    _logoController.dispose();
    _textController.dispose();
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

                // ── Contenido deslizable ──
                Expanded(
                  flex: 6,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      final page = _pages[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo / ilustración
                          FadeTransition(
                            opacity: _logoFade,
                            child: ScaleTransition(
                              scale: _logoScale,
                              child: AnimatedBuilder(
                                animation: _floatingAnim,
                                builder: (context, child) => Transform.translate(
                                  offset: Offset(0, -_floatingAnim.value),
                                  child: child,
                                ),
                                child: Image.asset(
                                  page.asset,
                                  width: 200,
                                  height: 180,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Título
                          FadeTransition(
                            opacity: _textFade,
                            child: SlideTransition(
                              position: _textSlide,
                              child: Text(
                                page.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A3E6E),
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Subtítulo
                          FadeTransition(
                            opacity: _textFade,
                            child: SlideTransition(
                              position: _textSlide,
                              child: Text(
                                page.subtitle,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF5A6E85),
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                const Spacer(flex: 1),

                // ── Dots ──
                _buildPageDots(),

                const SizedBox(height: 32),

                // ── Botón ──
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

  Widget _buildPageDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pages.length, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: isActive ? 22 : 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isActive
                ? const Color(0xFF1A3E6E)
                : const Color(0xFFBFCFDE),
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
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: ElevatedButton(
            key: ValueKey(_isLastPage), // fuerza rebuild animado
            onPressed: _isLastPage ? _goToLogin : _goToNextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A3E6E),
              foregroundColor: Colors.white,
              elevation: 6,
              shadowColor: const Color(0xFF1A3E6E).withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isLastPage ? 'Iniciar sesión' : 'Siguiente',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  _isLastPage
                      ? Icons.login_rounded
                      : Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
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