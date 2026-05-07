import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      body: Stack(
        children: [

          // 🔵 BACKGROUND
          Positioned.fill(
            child: Stack(
              children: [

                // 🔹 círculo grande abajo derecha
                Positioned(
                  bottom: -100,
                  right: -130,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      color: const Color(0xFF5DADE2).withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // 🔹 curva superior (círculo grande cortado)
                Positioned(
                  top: -200,
                  left: -250,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF5DADE2).withOpacity(0.3),
                        width: 1,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // 🔹 puntitos decorativos
                Positioned(top: 140, right: 40, child: _dot()),
                Positioned(top: 300, left: 30, child: _dot()),
                Positioned(bottom: 120, left: 20, child: _dot()),
                Positioned(bottom: 200, right: 60, child: _dot()),
              ],
            ),
          ),

          // 🟢 CONTENIDO
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
                bottom: 30,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 50),

                    // 🔹 LOGO
                    Center(
                      child: Image.asset(
                        'assets/logo.png',
                        width: 200,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔹 BIENVENIDA
                    const Text(
                      "¡Bienvenido\nde nuevo!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B2C3A),
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Inicia sesión para continuar",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // 🔹 EMAIL
                    const Text("Correo electrónico"),
                    const SizedBox(height: 4),

                    TextField(
                      decoration: InputDecoration(
                        hintText: "ejemplo@correo.com",
                        prefixIcon: const Icon(Icons.email_outlined),
                        filled: false,
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Color(0xFF1B4F72),
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔹 PASSWORD
                    const Text("Contraseña"),
                    const SizedBox(height: 4),

                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: const Icon(Icons.visibility_off),
                        filled: false,
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Color(0xFF1B4F72),
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // 🔹 OLVIDÉ CONTRASEÑA
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "¿Olvidaste tu contraseña?",
                          style: TextStyle(color: Color(0xFF1B4F72)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 🔹 BOTÓN LOGIN
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0B3C5D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Iniciar sesión",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔹 DIVIDER
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("o continúa con"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 🔹 SOCIAL
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialButton("assets/login/apple.png"),
                        const SizedBox(width: 20),
                        _socialButton("assets/login/google.png"),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // 🔹 REGISTRO
                    Center(
                      child: RichText(
                        text: const TextSpan(
                          text: "¿No tienes cuenta? ",
                          style: TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: "Regístrate",
                              style: TextStyle(
                                color: Color(0xFF1B4F72),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialButton(String asset) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          )
        ],
      ),
      child: Center(
        child: Image.asset(asset, width: 30),
      ),
    );
  }

  Widget _dot() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: const Color(0xFF5DADE2).withOpacity(0.5),
        shape: BoxShape.circle,
      ),
    );
  }
}