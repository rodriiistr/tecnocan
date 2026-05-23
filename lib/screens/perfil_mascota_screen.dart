import 'package:flutter/material.dart';

class MascotaPerfilScreen extends StatelessWidget {
  const MascotaPerfilScreen({super.key});

  // ───────────────── COLORS ─────────────────
  static const Color navy = Color(0xFF1A3E6E);
  static const Color bg = Color(0xFFF4F7FB);
  static const Color gray = Color(0xFF8A9BB0);
  static const Color lightBlue = Color(0xFFE8F0F8);
  static const Color green = Color(0xFF35C76F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ───────── HEADER ─────────
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: navy,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/perro.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: navy,
                      child: const Center(
                        child: Icon(
                          Icons.pets,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // overlay oscuro
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.15),
                          Colors.black.withOpacity(0.55),
                        ],
                      ),
                    ),
                  ),

                  // info
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Max',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            _badge('Golden Retriever'),
                            const SizedBox(width: 8),
                            _badge('3 años'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ───────── CONTENT ─────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // estado
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _topStat(
                            'Peso',
                            '28 kg',
                            Icons.monitor_weight_outlined,
                          ),
                        ),
                        Expanded(
                          child: _topStat(
                            'Comidas',
                            '3 al día',
                            Icons.restaurant_rounded,
                          ),
                        ),
                        Expanded(
                          child: _topStat(
                            'Estado',
                            'Saludable',
                            Icons.favorite_rounded,
                            color: green,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // información
                  _sectionTitle('Información general'),

                  const SizedBox(height: 14),

                  _infoCard(
                    icon: Icons.pets_rounded,
                    title: 'Raza',
                    value: 'Golden Retriever',
                  ),

                  _infoCard(
                    icon: Icons.cake_rounded,
                    title: 'Fecha de nacimiento',
                    value: '12/03/2023',
                  ),

                  _infoCard(
                    icon: Icons.male_rounded,
                    title: 'Sexo',
                    value: 'Macho',
                  ),

                  _infoCard(
                    icon: Icons.color_lens_outlined,
                    title: 'Color',
                    value: 'Dorado claro',
                  ),

                  _infoCard(
                    icon: Icons.local_hospital_outlined,
                    title: 'Última revisión',
                    value: 'Hace 2 semanas',
                  ),

                  const SizedBox(height: 22),

                  // alimentación
                  _sectionTitle('Rutina alimenticia'),

                  const SizedBox(height: 14),

                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      children: [
                        _mealTile(
                          'Desayuno',
                          '08:00 AM',
                          '100g',
                          true,
                        ),
                        const SizedBox(height: 12),
                        _mealTile(
                          'Almuerzo',
                          '01:00 PM',
                          '100g',
                          true,
                        ),
                        const SizedBox(height: 12),
                        _mealTile(
                          'Cena',
                          '06:00 PM',
                          '120g',
                          false,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // notas
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notas',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: navy,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Max es una mascota muy activa y amigable. '
                          'Se recomienda mantener horarios constantes '
                          'de alimentación y supervisar el nivel de agua.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: gray,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────── WIDGETS ─────────────────

  static Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static Widget _topStat(
    String title,
    String value,
    IconData icon, {
    Color color = navy,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: navy,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: gray,
          ),
        ),
      ],
    );
  }

  static Widget _sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: navy,
        ),
      ),
    );
  }

  static Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: navy),
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
                    color: gray,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: navy,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _mealTile(
    String title,
    String hour,
    String grams,
    bool done,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: done
            ? const Color(0xFFF2FFF7)
            : const Color(0xFFF8FAFD),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: done
                  ? green.withOpacity(0.15)
                  : lightBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              done
                  ? Icons.check_rounded
                  : Icons.schedule_rounded,
              color: done ? green : navy,
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
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: navy,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$hour · $grams',
                  style: const TextStyle(
                    fontSize: 12,
                    color: gray,
                  ),
                ),
              ],
            ),
          ),

          Text(
            done ? 'Completada' : 'Pendiente',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: done ? green : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}