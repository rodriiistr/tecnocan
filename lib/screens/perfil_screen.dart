import 'package:flutter/material.dart';
import 'package:tecnocan/data/app_database.dart';
import 'package:tecnocan/data/database_provider.dart';

class PerfilScreen extends StatefulWidget {
  final int userId;
  const PerfilScreen({super.key, required this.userId});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  static const Color _navy = Color(0xFF1A3E6E);
  static const Color _bg = Color(0xFFF4F7FB);
  static const Color _gray = Color(0xFF8A9BB0);

  User? _user;
  List<Pet> _pets = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    final db = DatabaseProvider.of(context);
    final user = await db.getUserById(widget.userId);
    final pets = await db.getPetsForUser(widget.userId);

    if (!mounted) return;
    setState(() {
      _user = user;
      _pets = pets;
      _isLoading = false;
    });
  }

  String get _nombreCompleto {
    if (_user == null) return '';
    final apellidoM = _user!.apellidoMaterno != null
        ? ' ${_user!.apellidoMaterno}'
        : '';
    return '${_user!.nombre} ${_user!.apellidoPaterno}$apellidoM';
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: _bg,
        body: Center(
          child: CircularProgressIndicator(color: _navy),
        ),
      );
    }

    if (_user == null) {
      return const Scaffold(
        backgroundColor: _bg,
        body: Center(
          child: Text(
            'No se encontró el usuario',
            style: TextStyle(color: _gray, fontSize: 15),
          ),
        ),
      );
    }

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
                          // Avatar
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
                                errorBuilder: (_, __, ___) => Container(
                                  color: const Color(0xFFE8EEF7),
                                  child: const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: _navy,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Nombre real
                          Text(
                            _nombreCompleto,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: _navy,
                            ),
                          ),

                          const SizedBox(height: 6),

                          const Text(
                            'Usuario TecnoCan',
                            style: TextStyle(fontSize: 14, color: _gray),
                          ),

                          const SizedBox(height: 22),

                          // Email real
                          _buildInfoTile(
                            Icons.email_outlined,
                            'Correo',
                            _user!.email,
                          ),

                          const SizedBox(height: 14),

                          const SizedBox(height: 14),

                          // Mascotas registradas
                          _buildInfoTile(
                            Icons.pets_outlined,
                            'Mascotas registradas',
                            _pets.isEmpty
                                ? 'Sin mascotas'
                                : _pets.length == 1
                                    ? '1 mascota (${_pets.first.name})'
                                    : '${_pets.length} mascotas',
                          ),

                          const SizedBox(height: 14),

                          // Miembro desde
                          _buildInfoTile(
                            Icons.calendar_today_outlined,
                            'Miembro desde',
                            _formatFecha(_user!.createdAt),
                          ),

                          const SizedBox(height: 26),

                          // Botón editar
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // TODO: abrir pantalla de edición
                              },
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

                          const SizedBox(height: 14),

                          // Botón cerrar sesión
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                              },
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                side: BorderSide(
                                    color: _navy.withOpacity(0.3)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Text(
                                'Cerrar sesión',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: _navy,
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

  String _formatFecha(int epochMs) {
    if (epochMs == 0) return 'Desconocido';
    final dt = DateTime.fromMillisecondsSinceEpoch(epochMs);
    const meses = [
      'ene', 'feb', 'mar', 'abr', 'may', 'jun',
      'jul', 'ago', 'sep', 'oct', 'nov', 'dic'
    ];
    return '${dt.day} ${meses[dt.month - 1]} ${dt.year}';
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
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
            child: Icon(icon, color: _navy),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: _gray),
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