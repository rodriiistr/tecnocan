import 'package:flutter/material.dart';
import 'alimento_screen.dart';

class MascotaScreen extends StatefulWidget {
  const MascotaScreen({super.key});

  @override
  State<MascotaScreen> createState() => _MascotaScreenState();
}

class _MascotaScreenState extends State<MascotaScreen>
    with SingleTickerProviderStateMixin {
  final _nombreController = TextEditingController();
  final _razaController = TextEditingController();
  DateTime? _fechaNacimiento;
  String? _sexo; // 'macho' | 'hembra'

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
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _razaController.dispose();
    _animController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1A3E6E),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _fechaNacimiento = picked);
  }

  String _formatFecha(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/'
        '${dt.month.toString().padLeft(2, '0')}/'
        '${dt.year}';
  }

  void _irASiguiente() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) =>
            const AlimentoScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),
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
                        padding:
                            const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            // Título (sin flecha)
                            const Center(
                              child: Text(
                                'Agrega a tu\nmascota',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1A3E6E),
                                  height: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Center(
                              child: Text(
                                'Cuéntanos más sobre él/ella',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF7A90A8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),
                            Center(child: _buildAvatar()),
                            const SizedBox(height: 32),
                            _buildLabel('Nombre'),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _nombreController,
                              hint: 'Ej. Max',
                            ),
                            const SizedBox(height: 20),
                            _buildLabel('Raza'),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _razaController,
                              hint: 'Ej. Golden Retriever',
                            ),
                            const SizedBox(height: 20),
                            _buildLabel('Fecha de nacimiento'),
                            const SizedBox(height: 8),
                            _buildDateField(),
                            const SizedBox(height: 20),
                            _buildLabel('Sexo'),
                            const SizedBox(height: 8),
                            _buildSexoSelector(),
                            const SizedBox(height: 32),
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
          top: -60,
          right: -80,
          child: Container(
            width: 240,
            height: 240,
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
          bottom: -40,
          left: -50,
          child: Container(
            width: 160,
            height: 160,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD6E8F5),
            ),
          ),
        ),
        Positioned(top: 130, left: 28, child: _dot(8, 0.5)),
        Positioned(top: 260, right: 32, child: _dot(12, 0.6)),
        Positioned(top: 180, right: 60, child: _dot(6, 0.3)),
      ],
    );
  }

  Widget _dot(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF5B9BD5).withOpacity(opacity),
      ),
    );
  }

  // ─── Avatar ───────────────────────────────────
  Widget _buildAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFE8F0F8),
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/mascota_placeholder.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.pets,
                size: 60,
                color: Color(0xFF1A3E6E),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: -8,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1A3E6E),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ─── Label ────────────────────────────────────
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1A3E6E),
      ),
    );
  }

  // ─── TextField ────────────────────────────────
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Color(0xFF1A3E6E)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFAFC3D5)),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDDE6EF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDDE6EF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Color(0xFF1A3E6E), width: 1.5),
        ),
      ),
    );
  }

  // ─── Date Field ───────────────────────────────
  Widget _buildDateField() {
    return GestureDetector(
      onTap: _seleccionarFecha,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFDDE6EF)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFF5B9BD5),
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              _fechaNacimiento != null
                  ? _formatFecha(_fechaNacimiento!)
                  : 'Selecciona la fecha',
              style: TextStyle(
                fontSize: 15,
                color: _fechaNacimiento != null
                    ? const Color(0xFF1A3E6E)
                    : const Color(0xFFAFC3D5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Sexo Selector ────────────────────────────
  Widget _buildSexoSelector() {
    return Row(
      children: [
        Expanded(child: _sexoBtn('macho', '♂', 'Macho')),
        const SizedBox(width: 12),
        Expanded(child: _sexoBtn('hembra', '♀', 'Hembra')),
      ],
    );
  }

  Widget _sexoBtn(String value, String icon, String label) {
    final isSelected = _sexo == value;
    return GestureDetector(
      onTap: () => setState(() => _sexo = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1A3E6E).withOpacity(0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF1A3E6E)
                : const Color(0xFFDDE6EF),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              icon,
              style: TextStyle(
                fontSize: 20,
                color: isSelected
                    ? const Color(0xFF1A3E6E)
                    : const Color(0xFF7A90A8),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? const Color(0xFF1A3E6E)
                    : const Color(0xFF7A90A8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Bottom (Siguiente + dots) ────────────────
  Widget _buildBottom() {
    return Container(
      color: const Color(0xFFF5F8FC),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _irASiguiente,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A3E6E),
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor:
                    const Color(0xFF1A3E6E).withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Siguiente',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Dots de progreso — paso 1 de 4
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (i) {
              final isActive = i == 0;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 22 : 10,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: isActive
                      ? const Color(0xFF1A3E6E)
                      : const Color(0xFFBFCFDE),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}