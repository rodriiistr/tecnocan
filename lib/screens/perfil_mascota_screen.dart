import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tecnocan/data/app_database.dart';
import 'package:tecnocan/data/database_provider.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:drift/drift.dart' show Value;

class MascotaPerfilScreen extends StatefulWidget {
  final int petId;

  const MascotaPerfilScreen({
    super.key,
    required this.petId,
  });

  @override
  State<MascotaPerfilScreen> createState() =>
      _MascotaPerfilScreenState();
}

class _MascotaPerfilScreenState
    extends State<MascotaPerfilScreen> {
  // ───────────────── COLORS ─────────────────
  static const Color navy = Color(0xFF1A3E6E);
  static const Color bg = Color(0xFFF4F7FB);
  static const Color gray = Color(0xFF8A9BB0);
  static const Color lightBlue = Color(0xFFE8F0F8);
  static const Color green = Color(0xFF35C76F);

  Pet? _pet;
  FeedingSchedule? _schedule;
  List<FeedingTime> _times = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(_loadData);
  }

  Future<void> _loadData() async {
    final db = DatabaseProvider.of(context);

    final pet = await db.getPetById(widget.petId);

    FeedingSchedule? schedule;
    List<FeedingTime> times = [];

    if (pet != null) {
      schedule = await db.getScheduleForPet(pet.id);

      if (schedule != null) {
        times = await db.getTimesForSchedule(schedule.id);
      }
    }

    if (!mounted) return;

    setState(() {
      _pet = pet;
      _schedule = schedule;
      _times = times;
      _loading = false;
    });
  }

  String _calcularEdad() {
    if (_pet == null) return '--';

    final birth =
        DateTime.fromMillisecondsSinceEpoch(
      _pet!.birthDate,
    );

    final age =
        DateTime.now().year - birth.year;

    return '$age años';
  }

  String _formatDate() {
    if (_pet == null) return '--';

    final date =
        DateTime.fromMillisecondsSinceEpoch(
      _pet!.birthDate,
    );

    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
                  GestureDetector(
                    onTap: _cambiarFoto,
                    child: _pet?.photoPath != null &&
                            _pet!.photoPath!.isNotEmpty
                        ? Image.file(
                            File(_pet!.photoPath!),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
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

                  // botón cambiar foto
                  Positioned(
                    bottom: 60,
                    right: 20,
                    child: GestureDetector(
                      onTap: _cambiarFoto,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.35),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.25),
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
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
                        Text(
                          _pet?.name ?? 'Sin nombre',
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            _badge(_pet?.breed ?? 'Sin raza'),
                            const SizedBox(width: 8),
                            _badge(_calcularEdad()),
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
                            '${_times.length} al día',
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
                    value: _pet?.breed ?? '--',
                  ),

                  _infoCard(
                    icon: Icons.cake_rounded,
                    title: 'Fecha de nacimiento',
                    value: _formatDate(),
                  ),

                  _infoCard(
                    icon: Icons.male_rounded,
                    title: 'Sexo',
                    value: _pet?.sex ?? '--',
                  ),

                  _infoCard(
                    icon: Icons.color_lens_outlined,
                    title: 'Color',
                    value: 'No especificado',
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
                        ..._times.map(
                          (time) => Padding(
                            padding:
                                const EdgeInsets.only(bottom: 12),
                            child: _mealTile(
                              time.name,
                              time.time,
                              '${time.amount.toStringAsFixed(0)}g',
                              false,
                            ),
                          ),
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
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
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
                          'La información de la mascota se sincroniza automáticamente con TecnoCan.',
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

  Future<void> _cambiarFoto() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Cambiar foto',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: navy,
                  ),
                ),

                const SizedBox(height: 20),

                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_rounded,
                    color: navy,
                  ),
                  title: const Text('Tomar foto'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),

                ListTile(
                  leading: const Icon(
                    Icons.photo_library_rounded,
                    color: navy,
                  ),
                  title: const Text('Elegir de galería'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
  final permission =
      source == ImageSource.camera
          ? Permission.camera
          : Permission.photos;

  final status = await permission.request();

  if (!status.isGranted) return;

  final picker = ImagePicker();

  final picked = await picker.pickImage(
    source: source,
    imageQuality: 80,
    maxWidth: 1000,
  );

  if (picked == null || _pet == null) return;

  final db = DatabaseProvider.of(context);

  await db.updatePet(
    _pet!.copyWith(
      photoPath: Value(picked.path),
    ),
  );

  final updatedPet =
      await db.getPetById(_pet!.id);

  if (!mounted) return;

  setState(() {
    _pet = updatedPet;
  });
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
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