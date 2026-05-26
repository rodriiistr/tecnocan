import 'package:flutter/material.dart';
import 'dart:async';
import 'package:tecnocan/data/app_database.dart';
import 'package:tecnocan/data/database_provider.dart';
import 'package:tecnocan/screens/deposito_screen.dart';
import 'package:tecnocan/screens/perfil_screen.dart';
import 'perfil_mascota_screen.dart';
// import 'dart:ui';
import 'dart:io';
import 'editar_alimento_screen.dart';

class HomeScreen extends StatefulWidget {
  final int userId;
  const HomeScreen({super.key, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentTab = 0;
  late Timer _timer;
  String _countdown = '--:--';

  // Datos de BD
  FeedingSchedule? _schedule;
  List<FeedingTime> _times = [];

  // User? _user;
  Pet? _pet;
  List<FeedingTime> _feedingTimes = [];
  bool _isLoading = true;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  // ─── PALETTE ───────────────────────────────────────────────────────────
  static const Color _navy = Color(0xFF1A3E6E);
  static const Color _navy2 = Color(0xFF1A3E6E);
  static const Color _navyLight = Color(0xFFE8F0F8);
  static const Color _accent = Color(0xFFF5A623);
  static const Color _accentRed = Color(0xFFFF6B35);
  static const Color _green = Color(0xFF2ECC71);
  static const Color _bg = Color(0xFFF2F6FB);
  static const Color _gray = Color(0xFF8A9BB0);
  static const Color _white = Colors.white;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..forward();
    _slideController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700))
      ..forward();
    _fadeAnim =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _slideAnim =
        Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
            CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _timer = Timer.periodic(
        const Duration(minutes: 1), (_) => _updateCountdown());

    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    final db = DatabaseProvider.of(context);

    final user = await db.getUserById(widget.userId);
    final pets = await db.getPetsForUser(widget.userId);

    if (pets.isEmpty) {
      setState(() => _isLoading = false);
      return;
    }

    final pet = pets.first;

    final schedule = await db.getScheduleForPet(pet.id);

    List<FeedingTime> times = [];

    if (schedule != null) {
      times = await db.getTimesForSchedule(schedule.id);
    }

    if (!mounted) return;

    setState(() {
      // _user = user;
      _pet = pet;

      _schedule = schedule;
      _times = times;

      _feedingTimes = times;

      _isLoading = false;
    });

    _updateCountdown();
  }

  void _updateCountdown() {
    final now = DateTime.now();
    final nowMinutes = now.hour * 60 + now.minute;

    FeedingTime? next;
    int minDiff = 99999;

    for (final t in _feedingTimes) {
      final parts = t.time.split(':');
      final tMinutes =
          int.parse(parts[0]) * 60 + int.parse(parts[1]);
      final diff = tMinutes > nowMinutes
          ? tMinutes - nowMinutes
          : tMinutes + 1440 - nowMinutes;
      if (diff < minDiff) {
        minDiff = diff;
        next = t;
      }
    }

    if (next == null) {
      if (mounted) setState(() => _countdown = '--:--');
      return;
    }

    final h = minDiff ~/ 60;
    final m = minDiff % 60;
    if (mounted) {
      setState(() => _countdown = '$h:${m.toString().padLeft(2, '0')}');
    }
  }

  FeedingTime? get _nextMeal {
    final now = DateTime.now();
    final nowMinutes = now.hour * 60 + now.minute;
    FeedingTime? next;
    int minDiff = 99999;
    for (final t in _feedingTimes) {
      final parts = t.time.split(':');
      final tMinutes = int.parse(parts[0]) * 60 + int.parse(parts[1]);
      final diff = tMinutes > nowMinutes
          ? tMinutes - nowMinutes
          : tMinutes + 1440 - nowMinutes;
      if (diff < minDiff) {
        minDiff = diff;
        next = t;
      }
    }
    return next;
  }

  String _petSubtitle(Pet pet) {
    final breed = pet.breed;
    final birth = DateTime.fromMillisecondsSinceEpoch(pet.birthDate);
    final age = DateTime.now().difference(birth).inDays ~/ 365;
    final ageStr = age == 1 ? '1 año' : '$age años';
    return '$breed · $ageStr';
  }

  String _totalGramsToday() {
    final total =
        _feedingTimes.fold<double>(0, (sum, t) => sum + t.amount);
    return '${total.toInt()}g';
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF2F6FB),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF1A3E6E)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: _bg,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: _currentTab,
                  children: [
                    _buildHomeContent(),
                    MascotaPerfilScreen(
                      petId: _pet!.id,
                    ),
                    const DepositoScreen(),
                    PerfilScreen(userId: widget.userId)
                  ],
                ),
              ),
              _buildBottomNav(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildStatusAndHeader(),
          _buildPetCard(),
          const SizedBox(height: 16),
          _buildNextMeal(),
          const SizedBox(height: 16),
          _buildScheduleSection(),
          const SizedBox(height: 16),
          _buildStatsRow(),
          const SizedBox(height: 16),
          _buildDispenseButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ─── STATUS + HEADER ──────────────────────────────────────────────────
  Widget _buildStatusAndHeader() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _pet != null ? 'Hola' : 'Bienvenido',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _navy,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Aquí está el resumen de hoy',
                    style: TextStyle(fontSize: 13, color: _gray),
                  ),
                ],
              ),
            ),
            const _NotifButton(),
          ],
        ),
      ),
    );
  }

  // ─── PET CARD ─────────────────────────────────────────────────────────
  Widget _buildPetCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _navy,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: _navy.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                    width: 2.5,
                  ),
                ),
                child: ClipOval(
                  child: _pet?.photoPath != null &&
                          _pet!.photoPath!.isNotEmpty
                      ? Image.file(
                          File(_pet!.photoPath!),
                          fit: BoxFit.cover,
                          width: 72,
                          height: 72,
                          errorBuilder: (_, __, ___) => const Center(
                            child: Text(
                              '🐕',
                              style: TextStyle(fontSize: 36),
                            ),
                          ),
                        )
                      : Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.cover,
                          width: 72,
                          height: 72,
                          errorBuilder: (_, __, ___) => const Center(
                            child: Text(
                              '🐕',
                              style: TextStyle(fontSize: 36),
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _pet?.name ?? 'Sin mascota',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _pet != null ? _petSubtitle(_pet!) : '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        _PetBadge(
                          label: 'Dispensador activo',
                          color: _green,
                        ),
                        _PetBadge(
                          label: '${_feedingTimes.length} tomas restantes hoy',
                          color: _accent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _PetStat(
                value: _totalGramsToday(),
                label: 'Hoy total',
              ),
              _PetStat(
                value: '0/${_feedingTimes.length}',
                label: 'Tomas',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── NEXT MEAL ────────────────────────────────────────────────────────
  Widget _buildNextMeal() {
    final next = _nextMeal;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(title: 'Próxima comida'),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _navy2.withOpacity(0.07)),
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3DC),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text('🍖', style: TextStyle(fontSize: 26)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('SIGUIENTE TOMA',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: _gray,
                              letterSpacing: 0.6)),
                      const SizedBox(height: 2),
                      Text(
                        next != null
                            ? '${next.name} — ${next.amount.toInt()}g'
                            : 'Sin tomas programadas',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: _navy),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        next != null ? 'Programada · ${next.time}' : '',
                        style: const TextStyle(
                            fontSize: 12, color: _gray),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: LinearProgressIndicator(
                          value: _nextMealProgress(),
                          backgroundColor: _navyLight,
                          valueColor:
                              const AlwaysStoppedAnimation(_navy2),
                          minHeight: 5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  children: [
                    Text(
                      _countdown,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: _accentRed,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                    const Text('hrs restantes',
                        style: TextStyle(fontSize: 10, color: _gray)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _nextMealProgress() {
    final next = _nextMeal;

    if (next == null) return 0;

    final now = DateTime.now();

    final parts = next.time.split(':');
    final nextHour = int.parse(parts[0]);
    final nextMinute = int.parse(parts[1]);

    DateTime nextDate = DateTime(
      now.year,
      now.month,
      now.day,
      nextHour,
      nextMinute,
    );

    // si ya pasó hoy, usar mañana
    if (nextDate.isBefore(now)) {
      nextDate = nextDate.add(const Duration(days: 1));
    }

    // buscar comida anterior
    final sorted = [..._feedingTimes];

    sorted.sort((a, b) {
      final aParts = a.time.split(':');
      final bParts = b.time.split(':');

      final aMinutes =
          int.parse(aParts[0]) * 60 + int.parse(aParts[1]);

      final bMinutes =
          int.parse(bParts[0]) * 60 + int.parse(bParts[1]);

      return aMinutes.compareTo(bMinutes);
    });

    FeedingTime previous = sorted.last;

    for (int i = 0; i < sorted.length; i++) {
      if (sorted[i].id == next.id) {
        previous = i == 0 ? sorted.last : sorted[i - 1];
        break;
      }
    }

    final prevParts = previous.time.split(':');

    DateTime prevDate = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(prevParts[0]),
      int.parse(prevParts[1]),
    );

    if (prevDate.isAfter(nextDate)) {
      prevDate = prevDate.subtract(const Duration(days: 1));
    }

    final total =
        nextDate.difference(prevDate).inMinutes;

    final current =
        now.difference(prevDate).inMinutes;

    double progress = current / total;

    return progress.clamp(0.0, 1.0);
  }

  // ─── SCHEDULE ─────────────────────────────────────────────────────────
  Widget _buildScheduleSection() {
    final now = DateTime.now();
    final nowMinutes = now.hour * 60 + now.minute;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _SectionHeader(
                title: 'Horarios del día',
              ),

              GestureDetector(
                onTap: () async {
                  if (_pet == null ||  _schedule == null) return;

                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          EditAlimentoScreen(
                        petId: _pet!.id,
                        schedule: _schedule!,
                        times: _times,
                      ),
                    ),
                  );

                  _loadData();
                },

                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),

                  decoration: BoxDecoration(
                    color: _navyLight,
                    borderRadius:
                        BorderRadius.circular(12),
                  ),

                  child: const Row(
                    children: [
                      Icon(
                        Icons.edit_rounded,
                        size: 16,
                        color: _navy2,
                      ),

                      SizedBox(width: 6),

                      Text(
                        'Editar',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _navy2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (_feedingTimes.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  'No hay horarios configurados',
                  style: TextStyle(color: _gray, fontSize: 14),
                ),
              ),
            )
          else
            ..._feedingTimes.map((t) {
              final parts = t.time.split(':');
              final tMinutes =
                  int.parse(parts[0]) * 60 + int.parse(parts[1]);
              final isPast = tMinutes < nowMinutes;
              final isNext = t.id == _nextMeal?.id;

              return _ScheduleItem(
                schedule: _MealSchedule(
                  hour: int.parse(parts[0]),
                  minute: int.parse(parts[1]),
                  label: t.name,
                  grams: t.amount.toInt(),
                  done: isPast,
                  enabled: true,
                ),
                isNext: isNext,
                accentRed: _accentRed,
                onToggle: (_) {},
              );
            }),
        ],
      ),
    );
  }

  // ─── STATS ROW ────────────────────────────────────────────────────────
  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _navy2.withOpacity(0.07)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('📦', style: TextStyle(fontSize: 22)),
                  const SizedBox(height: 6),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '2.1',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: _navy),
                        ),
                        TextSpan(
                          text: ' kg',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: _gray),
                        ),
                      ],
                    ),
                  ),
                  const Text('Alimento en tolva',
                      style: TextStyle(fontSize: 11, color: _gray)),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: LinearProgressIndicator(
                      value: 0.42,
                      backgroundColor: _navyLight,
                      valueColor:
                          const AlwaysStoppedAnimation(_navy2),
                      minHeight: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _navy,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 22)),
                  const SizedBox(height: 6),
                  const Text('7',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                  const Text('Días en racha',
                      style:
                          TextStyle(fontSize: 11, color: Colors.white54)),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(
                      7,
                      (i) => Container(
                        margin: const EdgeInsets.only(right: 4),
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF4CD964),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── DISPENSE BUTTONS ─────────────────────────────────────────────────
  Widget _buildDispenseButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _showDispenseDialog('food'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B35), Color(0xFFF5A623)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: _accentRed.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('🍖', style: TextStyle(fontSize: 22)),
                    SizedBox(width: 8),
                    Text('Alimento',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        )),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () => _showDispenseDialog('water'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2A5983), Color(0xFF3E7CB1)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('💧', style: TextStyle(fontSize: 22)),
                    SizedBox(width: 8),
                    Text('Agua',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDispenseDialog(String type) {
    final bool isFood = type == 'food';
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isFood ? 'Dispensar alimento' : 'Dispensar agua',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _navy),
            ),
            const SizedBox(height: 8),
            Text(
              isFood
                  ? '¿Cuántos gramos deseas dispensar?'
                  : '¿Cuántos ml deseas dispensar?',
              style: const TextStyle(fontSize: 14, color: _gray),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  (isFood ? [50, 80, 100, 120] : [100, 200, 300, 500])
                      .map((amount) {
                return GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: _navyLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isFood ? '${amount}g' : '${amount}ml',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: _navy2),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ─── BOTTOM NAV ───────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    final tabs = [
      (Icons.home_rounded, Icons.home_outlined, 'Inicio'),
      (Icons.pets, Icons.pets_outlined, 'Mascota'),
      (Icons.scale_rounded, Icons.scale_outlined, 'Depósito'),
      (Icons.person_rounded, Icons.person_outlined, 'Perfil'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: _white,
        boxShadow: [
          BoxShadow(
            color: _navy.withOpacity(0.07),
            blurRadius: 14,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tabs.asMap().entries.map((e) {
              final i = e.key;
              final tab = e.value;
              final active = _currentTab == i;
              return GestureDetector(
                onTap: () => setState(() => _currentTab = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: active ? _navy : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        active ? tab.$1 : tab.$2,
                        color: active ? Colors.white : _gray,
                        size: 22,
                      ),
                      if (active) ...[
                        const SizedBox(height: 4),
                        Text(
                          tab.$3,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
// HELPERS / SUB-WIDGETS
// ──────────────────────────────────────────────

class _MealSchedule {
  final int hour;
  final int minute;
  final String label;
  final int grams;
  final bool done;
  bool enabled;
  _MealSchedule({
    required this.hour,
    required this.minute,
    required this.label,
    required this.grams,
    required this.done,
    required this.enabled,
  });
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w800,
        color: Color(0xFF0F2744),
      ),
    );
  }
}

class _PetBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _PetBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }
}

class _PetStat extends StatelessWidget {
  final String value;
  final String label;
  const _PetStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(right: 8),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white54,
                    letterSpacing: 0.4)),
          ],
        ),
      ),
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  final _MealSchedule schedule;
  final bool isNext;
  final Color accentRed;
  final ValueChanged<bool> onToggle;

  const _ScheduleItem({
    required this.schedule,
    required this.isNext,
    required this.accentRed,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final timeStr =
        '${schedule.hour.toString().padLeft(2, '0')}:${schedule.minute.toString().padLeft(2, '0')}';
    final ampm = schedule.hour < 12 ? 'AM' : 'PM';
    final subtitleColor = schedule.done
        ? const Color(0xFF8A9BB0)
        : isNext
            ? accentRed
            : const Color(0xFF8A9BB0);
    final subtitle = schedule.done
        ? 'Completada'
        : isNext
            ? 'Próxima toma'
            : 'Pendiente';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isNext
              ? const Color(0xFF1A3E6E).withOpacity(0.2)
              : const Color(0xFF1A3E6E).withOpacity(0.07),
          width: isNext ? 1.5 : 0.5,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Column(
              children: [
                Text(
                  timeStr,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: isNext
                        ? accentRed
                        : const Color(0xFF0F2744),
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                Text(ampm,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8A9BB0))),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 36,
            color: const Color(0xFF1A3E6E).withOpacity(0.08),
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(schedule.label,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F2744))),
                const SizedBox(height: 2),
                Text(subtitle,
                    style:
                        TextStyle(fontSize: 12, color: subtitleColor)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${schedule.grams}g',
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A3E6E))),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () => onToggle(!schedule.enabled),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 38,
                  height: 22,
                  decoration: BoxDecoration(
                    color: schedule.enabled
                        ? const Color(0xFF1A3E6E)
                        : const Color(0xFFD0DBE8),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    alignment: schedule.enabled
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 2),
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3,
                              offset: Offset(0, 1))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NotifButton extends StatelessWidget {
  final int notificationCount;
  final VoidCallback? onTap;

  const _NotifButton({
    this.notificationCount = 3,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (_) => Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40, height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(Icons.notifications_active_rounded,
                            color: Color(0xFFFF6B35)),
                        SizedBox(width: 10),
                        Text('Notificaciones',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0F2744))),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildNotificationItem(
                      icon: Icons.restaurant_rounded,
                      title: 'Comida dispensada',
                      subtitle: 'Tu mascota recibió su porción',
                    ),
                    _buildNotificationItem(
                      icon: Icons.water_drop_rounded,
                      title: 'Agua dispensada',
                      subtitle: 'Se dispensaron 300ml',
                    ),
                    _buildNotificationItem(
                      icon: Icons.warning_amber_rounded,
                      title: 'Tolva baja',
                      subtitle: 'Queda menos de 500g de alimento',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
      child: Stack(
        children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: const Color(0xFF1A3E6E).withOpacity(0.1)),
              boxShadow: [
                BoxShadow(
                    color: const Color(0xFF0F2744).withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2)),
              ],
            ),
            child: const Icon(Icons.notifications_outlined,
                color: Color(0xFF0F2744), size: 20),
          ),
          if (notificationCount > 0)
            Positioned(
              top: 6, right: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFF6B35),
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                constraints: const BoxConstraints(
                    minWidth: 18, minHeight: 18),
                child: Center(
                  child: Text(
                    '$notificationCount',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  static Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F6FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF1A3E6E)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F2744))),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}