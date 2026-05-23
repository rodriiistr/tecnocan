import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dispositivo_screen.dart';

class AlimentoScreen extends StatefulWidget {
  const AlimentoScreen({super.key});

  @override
  State<AlimentoScreen> createState() => _AlimentoScreenState();
}

class _AlimentoScreenState extends State<AlimentoScreen>
    with SingleTickerProviderStateMixin {
  int _frecuencia = 3;
  final List<_HorarioEntry> _horarios = [];

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  static const Color _navy = Color(0xFF1A3E6E);
  static const Color _navyLight = Color(0xFFE8F0F8);
  static const Color _bg = Color(0xFFF5F8FC);
  static const Color _gray = Color(0xFF7A90A8);
  static const Color _border = Color(0xFFDDE6EF);

  // Nombres predeterminados sugeridos
  static const List<String> _nombresSugeridos = [
    'Desayuno', 'Almuerzo', 'Cena', 'Snack',
    'Merienda', 'Toma extra',
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _syncHorarios(3);
  }

  void _syncHorarios(int count) {
    final defaults = [
      _HorarioEntry(hora: const TimeOfDay(hour: 8, minute: 0), nombre: 'Desayuno', gramos: 100),
      _HorarioEntry(hora: const TimeOfDay(hour: 13, minute: 0), nombre: 'Almuerzo', gramos: 100),
      _HorarioEntry(hora: const TimeOfDay(hour: 18, minute: 0), nombre: 'Cena', gramos: 120),
      _HorarioEntry(hora: const TimeOfDay(hour: 21, minute: 0), nombre: 'Snack', gramos: 50),
    ];
    setState(() {
      _horarios.clear();
      for (int i = 0; i < count; i++) {
        _horarios.add(i < defaults.length
            ? defaults[i]
            : _HorarioEntry(
                hora: TimeOfDay(hour: 8 + i * 3, minute: 0),
                nombre: 'Toma ${i + 1}',
                gramos: 100));
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // ── Editar hora con TimePicker ─────────────────
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

  // ── Editar nombre con bottom sheet ────────────
  void _editarNombre(int index) {
    final ctrl = TextEditingController(text: _horarios[index].nombre);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
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
              // Handle
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
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w800, color: _navy)),
              const SizedBox(height: 14),
              // TextField personalizado
              TextField(
                controller: ctrl,
                autofocus: true,
                style: const TextStyle(
                    fontSize: 15, color: _navy, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: 'Ej. Desayuno',
                  hintStyle: const TextStyle(color: Color(0xFFAFC3D5)),
                  filled: true,
                  fillColor: _navyLight,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear_rounded,
                        size: 18, color: _gray),
                    onPressed: () => ctrl.clear(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Chips de sugerencias
              const Text('Sugerencias',
                  style: TextStyle(fontSize: 12, color: _gray,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _nombresSugeridos.map((nombre) {
                  return GestureDetector(
                    onTap: () => ctrl.text = nombre,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: _navyLight,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: _border),
                      ),
                      child: Text(nombre,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _navy)),
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Confirmar',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Editar gramos con bottom sheet ────────────
  void _editarGramos(int index) {
    final ctrl = TextEditingController(
        text: _horarios[index].gramos.toString());
    int tempGramos = _horarios[index].gramos;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setLocal) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
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
                // Handle
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
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: _navy)),
                const SizedBox(height: 20),
                // Stepper grande
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
                    // Input directo
                    SizedBox(
                      width: 110,
                      child: TextField(
                        controller: ctrl,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: _navy,
                        ),
                        decoration: InputDecoration(
                          suffixText: 'g',
                          suffixStyle: const TextStyle(
                              fontSize: 20,
                              color: _gray,
                              fontWeight: FontWeight.w600),
                          filled: true,
                          fillColor: _navyLight,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
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
                // Chips rápidos
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
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
                      setState(() =>
                          _horarios[index].gramos =
                              (parsed != null && parsed > 0)
                                  ? parsed
                                  : tempGramos);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _navy,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Confirmar',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: FadeTransition(
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

  // ─── Background ───────────────────────────────
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

  // ─── Header ───────────────────────────────────
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
            'Configura la alimentación',
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

  // ─── Bowl Icon ────────────────────────────────
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

  // ─── Frecuencia ───────────────────────────────
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              labels[i],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                                color: isSelected
                                    ? _navy
                                    : const Color(0xFF4A6280),
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

  // ─── Horario Card ─────────────────────────────
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
            // ── Hora (tappable) ──
            GestureDetector(
              onTap: () => _editarHora(index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
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
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: _navy),
                    ),
                    Text(_ampm(entry.hora),
                        style: const TextStyle(
                            fontSize: 10, color: _gray,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    const Icon(Icons.edit_rounded,
                        size: 10, color: _gray),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),

            // ── Nombre (tappable) ──
            Expanded(
              child: GestureDetector(
                onTap: () => _editarNombre(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 8),
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
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _navy),
                        ),
                      ),
                      const Icon(Icons.edit_rounded,
                          size: 12, color: _gray),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // ── Gramos ──
            GestureDetector(
              onTap: () => _editarGramos(index),
              child: Row(
                children: [
                  // Botón −
                  _SmallStepBtn(
                    icon: Icons.remove_rounded,
                    onTap: () {
                      if (entry.gramos > 10) {
                        setState(() => entry.gramos -= 10);
                      }
                    },
                  ),
                  const SizedBox(width: 6),
                  // Valor (tappable abre sheet)
                  Container(
                    constraints: const BoxConstraints(minWidth: 48),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: _navyLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${entry.gramos}g',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: _navy),
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Botón +
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

  // ─── Label ────────────────────────────────────
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

  // ─── Bottom ───────────────────────────────────
  Widget _buildBottom() {
    return Container(
      color: _bg,
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            // Guardar y volver a Home
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DispositivoScreen()),
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _navy,
            foregroundColor: Colors.white,
            elevation: 4,
            shadowColor: _navy.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            'Guardar',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

// ─── Data class ───────────────────────────────
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

// ─── Small inline +/- button ──────────────────
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

// ─── Big stepper button (inside bottom sheet) ─
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