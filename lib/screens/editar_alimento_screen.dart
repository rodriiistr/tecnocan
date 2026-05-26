import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tecnocan/data/app_database.dart';
import 'package:tecnocan/data/database_provider.dart';

class EditAlimentoScreen extends StatefulWidget {
  final int petId;
  final FeedingSchedule schedule;
  final List<FeedingTime> times;

  const EditAlimentoScreen({
    super.key,
    required this.petId,
    required this.schedule,
    required this.times,
  });

  @override
  State<EditAlimentoScreen> createState() => _EditAlimentoScreenState();
}

class _EditAlimentoScreenState extends State<EditAlimentoScreen>
    with SingleTickerProviderStateMixin {
  static const Color _navy = Color(0xFF1A3E6E);
  static const Color _navyLight = Color(0xFFE8F0F8);
  static const Color _bg = Color(0xFFF5F8FC);
  static const Color _gray = Color(0xFF7A90A8);
  static const Color _border = Color(0xFFDDE6EF);

  static const List<String> _nombresSugeridos = [
    'Desayuno', 'Almuerzo', 'Cena', 'Snack',
    'Merienda', 'Toma extra',
  ];

  int _frecuencia = 1;
  bool _isLoading = true;
  bool _saving = false;

  FeedingSchedule? _schedule;
  final List<_HorarioEntry> _horarios = [];

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSchedule();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _loadSchedule() async {
    try {
      final db = DatabaseProvider.of(context);
      final schedule = await db.getScheduleForPet(widget.petId);

      if (schedule == null) {
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      final times = await db.getTimesForSchedule(schedule.id);

      if (!mounted) return;

      setState(() {
        _schedule = schedule;
        _frecuencia = schedule.frequency;
        _horarios.clear();

        for (final t in times) {
          final parts = t.time.split(':');
          _horarios.add(_HorarioEntry(
            hora: TimeOfDay(
              hour: int.parse(parts[0]),
              minute: int.parse(parts[1]),
            ),
            nombre: t.name,
            gramos: t.amount.toInt(),
          ));
        }

        _isLoading = false;
      });

      _animController.forward();
    } catch (e) {
      debugPrint('Error cargando horarios: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _syncHorarios(int count) {
    final defaults = [
      _HorarioEntry(hora: const TimeOfDay(hour: 8, minute: 0), nombre: 'Desayuno', gramos: 100),
      _HorarioEntry(hora: const TimeOfDay(hour: 13, minute: 0), nombre: 'Almuerzo', gramos: 100),
      _HorarioEntry(hora: const TimeOfDay(hour: 18, minute: 0), nombre: 'Cena', gramos: 120),
      _HorarioEntry(hora: const TimeOfDay(hour: 21, minute: 0), nombre: 'Snack', gramos: 50),
    ];

    setState(() {
      if (count > _horarios.length) {
        // Agregar entradas faltantes
        for (int i = _horarios.length; i < count; i++) {
          _horarios.add(i < defaults.length
              ? defaults[i]
              : _HorarioEntry(
                  hora: TimeOfDay(hour: 8 + i * 3, minute: 0),
                  nombre: 'Toma ${i + 1}',
                  gramos: 100));
        }
      } else {
        // Eliminar entradas sobrantes
        _horarios.removeRange(count, _horarios.length);
      }
    });
  }

  Future<void> _guardarCambios() async {
    if (_schedule == null) return;
    setState(() => _saving = true);

    final db = DatabaseProvider.of(context);

    await db.updateSchedule(_schedule!.copyWith(frequency: _frecuencia));
    await db.deleteTimesForSchedule(_schedule!.id);

    final nuevosHorarios = _horarios.map((h) {
      final hh = h.hora.hour.toString().padLeft(2, '0');
      final mm = h.hora.minute.toString().padLeft(2, '0');
      return FeedingTimesCompanion.insert(
        scheduleId: _schedule!.id,
        name: h.nombre,
        time: '$hh:$mm',
        amount: h.gramos.toDouble(),
      );
    }).toList();

    await db.insertFeedingTimes(nuevosHorarios);

    if (!mounted) return;
    setState(() => _saving = false);
    Navigator.pop(context, true);
  }

  Future<void> _editarHora(int index) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _horarios[index].hora,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: _navy,
            onPrimary: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _horarios[index].hora = picked);
  }

  void _editarNombre(int index) {
    final ctrl = TextEditingController(text: _horarios[index].nombre);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Nombre de la toma',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: _navy)),
              const SizedBox(height: 14),
              TextField(
                controller: ctrl,
                autofocus: true,
                style: const TextStyle(fontSize: 15, color: _navy, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: 'Ej. Desayuno',
                  hintStyle: const TextStyle(color: Color(0xFFAFC3D5)),
                  filled: true,
                  fillColor: _navyLight,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear_rounded, size: 18, color: _gray),
                    onPressed: () => ctrl.clear(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Sugerencias',
                  style: TextStyle(fontSize: 12, color: _gray, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _nombresSugeridos.map((nombre) {
                  return GestureDetector(
                    onTap: () => ctrl.text = nombre,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: _navyLight,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: _border),
                      ),
                      child: Text(nombre,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600, color: _navy)),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final val = ctrl.text.trim();
                    if (val.isNotEmpty) {
                      setState(() => _horarios[index].nombre = val);
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _navy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Confirmar',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editarGramos(int index) {
    final ctrl = TextEditingController(text: _horarios[index].gramos.toString());
    int tempGramos = _horarios[index].gramos;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setLocal) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40, height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Gramos para ${_horarios[index].nombre}',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w800, color: _navy)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _BigStepBtn(
                      icon: Icons.remove_rounded,
                      onTap: () {
                        if (tempGramos > 10) {
                          setLocal(() => tempGramos -= 10);
                          ctrl.text = tempGramos.toString();
                        }
                      },
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 110,
                      child: TextField(
                        controller: ctrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: _navy,
                        ),
                        decoration: InputDecoration(
                          suffixText: 'g',
                          suffixStyle: const TextStyle(
                              fontSize: 20, color: _gray, fontWeight: FontWeight.w600),
                          filled: true,
                          fillColor: _navyLight,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        ),
                        onChanged: (v) {
                          final parsed = int.tryParse(v);
                          if (parsed != null && parsed > 0) {
                            setLocal(() => tempGramos = parsed);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    _BigStepBtn(
                      icon: Icons.add_rounded,
                      onTap: () {
                        setLocal(() => tempGramos += 10);
                        ctrl.text = tempGramos.toString();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: Wrap(
                    spacing: 8,
                    children: [50, 80, 100, 120, 150, 200].map((g) {
                      final isSel = tempGramos == g;
                      return GestureDetector(
                        onTap: () {
                          setLocal(() => tempGramos = g);
                          ctrl.text = g.toString();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSel ? _navy : _navyLight,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text('${g}g',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: isSel ? Colors.white : _navy,
                              )),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      final parsed = int.tryParse(ctrl.text);
                      setState(() => _horarios[index].gramos =
                          (parsed != null && parsed > 0) ? parsed : tempGramos);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _navy,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Confirmar',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay t) {
    final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String _ampm(TimeOfDay t) => t.period == DayPeriod.am ? 'AM' : 'PM';

  // ─── BUILD ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: _navy))
                : FadeTransition(
                    opacity: _fadeAnim,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  _buildHeader(),
                                  const SizedBox(height: 28),
                                  _buildBowlIcon(),
                                  const SizedBox(height: 28),
                                  _buildFrecuenciaSelector(),
                                  const SizedBox(height: 24),
                                  if (_horarios.isNotEmpty) ...[
                                    _buildLabel('Horarios y porciones'),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Toca la hora, el nombre o los gramos para editar',
                                      style: TextStyle(fontSize: 12, color: _gray),
                                    ),
                                    const SizedBox(height: 12),
                                    ..._horarios.asMap().entries.map(
                                          (e) => _buildHorarioCard(e.key, e.value),
                                        ),
                                  ],
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),
                          _buildBottom(),
                        ],
                      ),
                    ),
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
          top: -60, right: -80,
          child: Container(
            width: 240, height: 240,
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
          bottom: -40, left: -50,
          child: Container(
            width: 160, height: 160,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD6E8F5),
            ),
          ),
        ),
        Positioned(top: 130, left: 28, child: _dot(8, 0.5)),
        Positioned(top: 260, right: 32, child: _dot(12, 0.4)),
        Positioned(top: 180, right: 60, child: _dot(6, 0.3)),
      ],
    );
  }

  Widget _dot(double size, double opacity) => Container(
        width: size, height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF5B9BD5).withOpacity(opacity),
        ),
      );

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _border),
            ),
            child: const Icon(Icons.arrow_back_rounded, color: _navy, size: 20),
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Text(
            'Editar alimentación',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: _navy,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBowlIcon() {
    return Center(
      child: Container(
        width: 110, height: 110,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFE8F0F8),
        ),
        child: const Center(
          child: Text('🍽️', style: TextStyle(fontSize: 52)),
        ),
      ),
    );
  }

  Widget _buildFrecuenciaSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Frecuencia de alimentación por día'),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _border),
          ),
          child: Column(
            children: List.generate(4, (i) {
              final val = i + 1;
              final labels = [
                '1 vez al día', '2 veces al día',
                '3 veces al día', '4 veces al día',
              ];
              final isSelected = _frecuencia == val;
              final isLast = i == 3;
              return GestureDetector(
                onTap: () {
                  setState(() => _frecuencia = val);
                  _syncHorarios(val);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  decoration: BoxDecoration(
                    color: isSelected ? _navyLight : Colors.transparent,
                    borderRadius: BorderRadius.vertical(
                      top: i == 0 ? const Radius.circular(12) : Radius.zero,
                      bottom: isLast ? const Radius.circular(12) : Radius.zero,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              labels[i],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                                color: isSelected ? _navy : const Color(0xFF4A6280),
                              ),
                            ),
                            if (isSelected)
                              Container(
                                width: 22, height: 22,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _navy,
                                ),
                                child: const Icon(Icons.check_rounded,
                                    color: Colors.white, size: 14),
                              ),
                          ],
                        ),
                      ),
                      if (!isLast)
                        const Divider(
                            height: 1,
                            color: Color(0xFFECF2F8),
                            indent: 18,
                            endIndent: 18),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildHorarioCard(int index, _HorarioEntry entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => _editarHora(index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: _navyLight,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _border),
                ),
                child: Column(
                  children: [
                    Text(
                      _formatTime(entry.hora),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800, color: _navy),
                    ),
                    Text(_ampm(entry.hora),
                        style: const TextStyle(
                            fontSize: 10, color: _gray, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    const Icon(Icons.edit_rounded, size: 10, color: _gray),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () => _editarNombre(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: _navyLight,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _border),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.nombre,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700, color: _navy),
                        ),
                      ),
                      const Icon(Icons.edit_rounded, size: 12, color: _gray),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => _editarGramos(index),
              child: Row(
                children: [
                  _SmallStepBtn(
                    icon: Icons.remove_rounded,
                    onTap: () {
                      if (entry.gramos > 10) setState(() => entry.gramos -= 10);
                    },
                  ),
                  const SizedBox(width: 6),
                  Container(
                    constraints: const BoxConstraints(minWidth: 48),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: _navyLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${entry.gramos}g',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w800, color: _navy),
                    ),
                  ),
                  const SizedBox(width: 6),
                  _SmallStepBtn(
                    icon: Icons.add_rounded,
                    onTap: () => setState(() => entry.gramos += 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: _navy,
      ),
    );
  }

  Widget _buildBottom() {
    return Container(
      color: _bg,
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _saving ? null : _guardarCambios,
          style: ElevatedButton.styleFrom(
            backgroundColor: _navy,
            foregroundColor: Colors.white,
            elevation: 4,
            shadowColor: _navy.withOpacity(0.4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: _saving
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
              : const Text(
                  'Guardar cambios',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
        ),
      ),
    );
  }
}

// ─── Modelos y botones ────────────────────────────────────────────────────────

class _HorarioEntry {
  TimeOfDay hora;
  String nombre;
  int gramos;

  _HorarioEntry({
    required this.hora,
    required this.nombre,
    required this.gramos,
  });
}

class _SmallStepBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _SmallStepBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28, height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFE8F0F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: const Color(0xFF1A3E6E)),
      ),
    );
  }
}

class _BigStepBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _BigStepBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52, height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFE8F0F8),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, size: 26, color: const Color(0xFF1A3E6E)),
      ),
    );
  }
}