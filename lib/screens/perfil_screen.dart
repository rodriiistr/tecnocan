import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  static const Color _navy = Color(0xFF1A3E6E);
  static const Color _bg = Color(0xFFF4F7FB);
  static const Color _gray = Color(0xFF8A9BB0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // Título
                    const Text(
                      'Perfil',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: _navy,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Card principal
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Foto
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _navy.withOpacity(0.15),
                                width: 3,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/profile.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) {
                                  return Container(
                                    color: const Color(0xFFE8EEF7),
                                    child: const Icon(
                                      Icons.person,
                                      size: 60,
                                      color: _navy,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          const Text(
                            'Andrés Gómez',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: _navy,
                            ),
                          ),

                          const SizedBox(height: 6),

                          const Text(
                            'Usuario Premium',
                            style: TextStyle(
                              fontSize: 14,
                              color: _gray,
                            ),
                          ),

                          const SizedBox(height: 22),

                          // Info cards
                          _buildInfoTile(
                            Icons.email_outlined,
                            'Correo',
                            'andres@gmail.com',
                          ),

                          const SizedBox(height: 14),

                          _buildInfoTile(
                            Icons.phone_outlined,
                            'Teléfono',
                            '+52 961 123 4567',
                          ),

                          const SizedBox(height: 14),

                          _buildInfoTile(
                            Icons.location_on_outlined,
                            'Ubicación',
                            'Tuxtla Gutiérrez, Chiapas',
                          ),

                          const SizedBox(height: 14),

                          _buildInfoTile(
                            Icons.pets_outlined,
                            'Mascotas registradas',
                            '2 mascotas',
                          ),

                          const SizedBox(height: 26),

                          // Botón editar
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _navy,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Text(
                                'Editar perfil',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
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
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: _navy.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: _navy,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: _gray,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _navy,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}