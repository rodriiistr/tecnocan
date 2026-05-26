import 'package:flutter/material.dart';

class DepositoScreen extends StatelessWidget {
  const DepositoScreen({super.key});

  static const Color navy = Color(0xFF1A3E6E);
  static const Color bg = Color(0xFFF5F8FC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Título
              const Text(
                'Depósitos',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: navy,
                ),
              ),

              const SizedBox(height: 24),

              // Card principal
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: navy.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        // Imagen
                        SizedBox(
                          height: 330,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: Image.asset(
                              'assets/prototipo-frontal.png',
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) {
                                return Center(
                                  child: Image.asset(
                                    'assets/logo.png',
                                    width: 120,
                                    fit: BoxFit.contain,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Indicadores
                        Row(
                          children: [
                            Expanded(
                              child: _buildIndicator(
                                title: 'Croqueta',
                                percent: 0.45,
                                color: const Color(0xFF9ED0FF),
                              ),
                            ),

                            const SizedBox(width: 20),

                            Expanded(
                              child: _buildIndicator(
                                title: 'Agua',
                                percent: 0.85,
                                color: navy,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // Estado
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F8FC),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text(
                            'Dispensador sincronizado y funcionando correctamente.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7A90),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Botón flotante
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.refresh_rounded,
                            color: navy,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator({
    required String title,
    required double percent,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: navy,
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: percent,
                  strokeWidth: 10,
                  backgroundColor: const Color(0xFFE7EDF5),
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${(percent * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Disponible',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF7B8CA5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}