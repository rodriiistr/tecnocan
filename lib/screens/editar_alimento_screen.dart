import 'package:flutter/material.dart';
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
  State<EditAlimentoScreen> createState() =>
      _EditAlimentoScreenState();
}

class _EditAlimentoScreenState
    extends State<EditAlimentoScreen> {
  static const Color _navy = Color(0xFF1A3E6E);
  static const Color _navyLight = Color(0xFFE8F0F8);
  static const Color _bg = Color(0xFFF5F8FC);
  static const Color _gray = Color(0xFF7A90A8);
  static const Color _border = Color(0xFFDDE6EF);

  int _frecuencia = 1;

  bool _isLoading = true;
  bool _saving = false;

  FeedingSchedule? _schedule;

  final List<_HorarioEntry> _horarios = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSchedule();
    });
  }

  Future<void> _loadSchedule() async {
    try {
      final db = DatabaseProvider.of(context);

      final schedule =
          await db.getScheduleForPet(widget.petId);

      if (schedule == null) {
        if (mounted) {
          setState(() => _isLoading = false);
        }
        return;
      }

      final times =
          await db.getTimesForSchedule(schedule.id);

      if (!mounted) return;

      setState(() {
        _schedule = schedule;
        _frecuencia = schedule.frequency;

        _horarios.clear();

        for (final t in times) {
          final parts = t.time.split(':');

          _horarios.add(
            _HorarioEntry(
              hora: TimeOfDay(
                hour: int.parse(parts[0]),
                minute: int.parse(parts[1]),
              ),
              nombre: t.name,
              gramos: t.amount.toInt(),
            ),
          );
        }

        _isLoading = false;
      });
    } catch (e) {
      debugPrint(
        'Error cargando horarios: $e',
      );

      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _guardarCambios() async {
    if (_schedule == null) return;

    setState(() => _saving = true);

    final db = DatabaseProvider.of(context);

    await db.updateSchedule(
      _schedule!.copyWith(
        frequency: _frecuencia,
      ),
    );

    await db.deleteTimesForSchedule(
      _schedule!.id,
    );

    final nuevosHorarios = _horarios.map((h) {
      final hh =
          h.hora.hour.toString().padLeft(2, '0');

      final mm =
          h.hora.minute.toString().padLeft(2, '0');

      return FeedingTimesCompanion.insert(
        scheduleId: _schedule!.id,
        name: h.nombre,
        time: '$hh:$mm',
        amount: h.gramos.toDouble(),
      );
    }).toList();

    await db.insertFeedingTimes(
      nuevosHorarios,
    );

    if (!mounted) return;

    setState(() => _saving = false);

    Navigator.pop(context, true);
  }

  Future<void> _editarHora(int index) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _horarios[index].hora,
    );

    if (picked != null) {
      setState(() {
        _horarios[index].hora = picked;
      });
    }
  }

  void _editarNombre(int index) async {
    final controller = TextEditingController(
      text: _horarios[index].nombre,
    );

    final result = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar nombre'),
        content: TextField(
          controller: controller,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                controller.text.trim(),
              );
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        _horarios[index].nombre = result;
      });
    }
  }

  void _editarGramos(int index) async {
    final controller = TextEditingController(
      text: _horarios[index].gramos.toString(),
    );

    final result = await showDialog<int>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar gramos'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                int.tryParse(controller.text),
              );
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() {
        _horarios[index].gramos = result;
      });
    }
  }

  String _formatTime(TimeOfDay t) {
    final h =
        t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;

    final m =
        t.minute.toString().padLeft(2, '0');

    return '$h:$m';
  }

  String _ampm(TimeOfDay t) =>
      t.period == DayPeriod.am ? 'AM' : 'PM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,

      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Editar alimentación',
          style: TextStyle(
            color: _navy,
            fontWeight: FontWeight.w800,
          ),
        ),
        iconTheme: const IconThemeData(
          color: _navy,
        ),
      ),

      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const Text(
                        'Frecuencia',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: _navy,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(14),
                          border:
                              Border.all(color: _border),
                        ),
                        child: DropdownButton<int>(
                          value: _frecuencia,
                          isExpanded: true,
                          underline:
                              const SizedBox.shrink(),
                          items: [1, 2, 3, 4]
                              .map(
                                (e) =>
                                    DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    '$e veces al día',
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (v) {
                            if (v == null) return;

                            setState(() {
                              _frecuencia = v;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'Horarios',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: _navy,
                        ),
                      ),

                      const SizedBox(height: 14),

                      ..._horarios.asMap().entries.map(
                        (entry) {
                          final index = entry.key;
                          final item = entry.value;

                          return Container(
                            margin:
                                const EdgeInsets.only(
                              bottom: 12,
                            ),
                            padding:
                                const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(
                                      16),
                              border: Border.all(
                                color: _border,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.schedule,
                                      color: _navy,
                                    ),

                                    const SizedBox(
                                        width: 10),

                                    Expanded(
                                      child: Text(
                                        '${_formatTime(item.hora)} ${_ampm(item.hora)}',
                                        style:
                                            const TextStyle(
                                          fontWeight:
                                              FontWeight
                                                  .w700,
                                          color: _navy,
                                        ),
                                      ),
                                    ),

                                    IconButton(
                                      onPressed: () =>
                                          _editarHora(
                                              index),
                                      icon: const Icon(
                                        Icons
                                            .edit_rounded,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.nombre,
                                        style:
                                            const TextStyle(
                                          color: _gray,
                                        ),
                                      ),
                                    ),

                                    TextButton(
                                      onPressed: () =>
                                          _editarNombre(
                                              index),
                                      child:
                                          const Text(
                                        'Editar',
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${item.gramos}g',
                                        style:
                                            const TextStyle(
                                          color: _gray,
                                        ),
                                      ),
                                    ),

                                    TextButton(
                                      onPressed: () =>
                                          _editarGramos(
                                              index),
                                      child:
                                          const Text(
                                        'Editar',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed:
                          _saving
                              ? null
                              : _guardarCambios,
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor: _navy,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                                  14),
                        ),
                      ),
                      child: _saving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child:
                                  CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Guardar cambios',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

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