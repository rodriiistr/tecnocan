import 'package:flutter/material.dart';
import 'package:tecnocan/screens/presentation_screen.dart';

const Color _colorPrimary = Color(0xFF5A6E85);
const Color _colorDark = Color(0xFF1A3E6E);
const Duration _animDuration = Duration(milliseconds: 1800);

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoSlide;
  late final Animation<double> _textOpacity;
  late final Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _animDuration);

    _logoScale = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.45, curve: Curves.elasticOut),
      ),
    );

    _logoSlide = Tween<double>(begin: 0.0, end: -22.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOutCubic),
      ),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 1.0, curve: Curves.easeIn),
      ),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0.15, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    // Navega después de la animación + una pausa breve
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 600), _goToLogin);
      }
    });
  }

  void _goToLogin() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const PresentationScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo animado
                Transform.translate(
                  offset: Offset(_logoSlide.value, 0),
                  child: Transform.scale(
                    scale: _logoScale.value,
                    child: Image.asset('assets/logo.png', width: 100),
                  ),
                ),

                const SizedBox(width: 8),

                // Texto animado con fade + slide
                FadeTransition(
                  opacity: _textOpacity,
                  child: SlideTransition(
                    position: _textSlide,
                    child: const _BrandText(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Widget separado para el texto de marca (stateless, más limpio)
class _BrandText extends StatelessWidget {
  const _BrandText();

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 26, fontWeight: FontWeight.bold);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Tecno', style: style.copyWith(color: _colorPrimary)),
        Text('Can', style: style.copyWith(color: _colorDark)),
      ],
    );
  }
}