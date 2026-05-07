import 'package:flutter/material.dart';
import 'package:tecnocan/screens/login_screen.dart';
import 'dart:async';
// import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> scaleAnimation;
  late Animation<double> moveAnimation;
  late Animation<double> textOpacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    moveAnimation = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 1, curve: Curves.easeInOut),
      ),
    );

    textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.6, 1, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    Timer(Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    });
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

      // 👇 Esto garantiza centrado REAL
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {

            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // 🔹 LOGO
                Transform.translate(
                  offset: Offset(moveAnimation.value, 0),
                  child: Transform.scale(
                    scale: scaleAnimation.value,
                    child: Image.asset(
                      'assets/logo.png',
                      width: 50,
                    ),
                  ),
                ),

                // 🔹 TEXTO
                SizedBox(width: 8),

                Opacity(
                  opacity: textOpacity.value,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Tecno",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5DADE2),
                        ),
                      ),
                      Text(
                        "Can",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B4F72),
                        ),
                      ),
                    ],
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