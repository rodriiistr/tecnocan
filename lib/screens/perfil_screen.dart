import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import 'package:tecnocan/data/app_database.dart';
import 'package:tecnocan/data/database_provider.dart';
import 'login_screen.dart';

class PerfilScreen extends StatefulWidget {
  final int userId;
  const PerfilScreen({super.key, required this.userId});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen>
    with SingleTickerProviderStateMixin {
  // ─── Paleta ───────────────────────────────────────────────────────────────
  static const Color _navy      = Color(0xFF1A3E6E);
  static const Color _navyLight = Color(0xFFE8F0F8);
  static const Color _bg        = Color(0xFFF4F7FB);
  static const Color _gray      = Color(0xFF8A9BB0);
  static const Color _border    = Color(0xFFDDE6EF);
  static const Color _red       = Color(0xFFD94F4F);

  // ─── Estado ───────────────────────────────────────────────────────────────
  User? _user;
  bool  _isLoading     = true;
  bool  _notifEnabled  = true;

  late AnimationController _animCtrl;
  late Animation<double>   _fadeAnim;
  late Animation<Offset>   _slideAnim;

  // ─── Init / dispose ───────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut)
        .drive(Tween(begin: 0.0, end: 1.0));
    _slideAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut)
        .drive(Tween(begin: const Offset(0, 0.06), end: Offset.zero));

    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  // ─── Carga ────────────────────────────────────────────────────────────────
  Future<void> _loadData() async {
    final db   = DatabaseProvider.of(context);
    final user = await db.getUserById(widget.userId);
    if (!mounted) return;
    setState(() {
      _user      = user;
      _isLoading = false;
    });
    _animCtrl.forward();
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────
  String get _nombreCompleto {
    if (_user == null) return '';
    final apellidoM = _user!.apellidoMaterno != null ? ' ${_user!.apellidoMaterno}' : '';
    return '${_user!.nombre} ${_user!.apellidoPaterno}$apellidoM';
  }

  String _formatFecha(int epochMs) {
    if (epochMs == 0) return 'Desconocido';
    final dt = DateTime.fromMillisecondsSinceEpoch(epochMs);
    const meses = ['ene','feb','mar','abr','may','jun','jul','ago','sep','oct','nov','dic'];
    return '${dt.day} ${meses[dt.month - 1]} ${dt.year}';
  }

  // ─── Acciones ─────────────────────────────────────────────────────────────
  void _abrirEditarPerfil() {
    if (_user == null) return;

    final nombreCtrl    = TextEditingController(text: _user!.nombre);
    final apellidoPCtrl = TextEditingController(text: _user!.apellidoPaterno);
    final apellidoMCtrl = TextEditingController(text: _user!.apellidoMaterno ?? '');
    final emailCtrl     = TextEditingController(text: _user!.email);
    bool saving = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 36),
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
                const Text('Editar perfil',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _navy)),
                const SizedBox(height: 20),
                _sheetField(nombreCtrl,    'Nombre',                   Icons.person_outline),
                const SizedBox(height: 12),
                _sheetField(apellidoPCtrl, 'Apellido paterno',         Icons.badge_outlined),
                const SizedBox(height: 12),
                _sheetField(apellidoMCtrl, 'Apellido materno (opcional)', Icons.badge_outlined),
                const SizedBox(height: 12),
                _sheetField(emailCtrl,    'Correo electrónico',        Icons.email_outlined,
                    keyboard: TextInputType.emailAddress),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: saving
                      ? null
                      : () async {
                          setLocal(() => saving = true);

                          BuildContext? dialogContext;

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (ctx) {
                              dialogContext = ctx;
                              return const AlertDialog(
                                content: Row(
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(width: 16),
                                    Text("Guardando cambios..."),
                                  ],
                                ),
                              );
                            },
                          );

                          try {
                            final db = DatabaseProvider.of(context);

                            final actualizado = UsersCompanion(
                              id: Value(_user!.id),
                              nombre: Value(nombreCtrl.text.trim()),
                              apellidoPaterno: Value(apellidoPCtrl.text.trim()),
                              apellidoMaterno: Value(
                                apellidoMCtrl.text.trim().isEmpty
                                    ? null
                                    : apellidoMCtrl.text.trim(),
                              ),
                              email: Value(emailCtrl.text.trim()),
                            );

                            await db.updateUser(actualizado);

                            final userActualizado =
                                await db.getUserById(widget.userId);

                            if (!mounted) return;

                            setState(() => _user = userActualizado);

                            // ✅ cerrar dialog
                            if (dialogContext != null) {
                              Navigator.pop(dialogContext!);
                            }

                            // ✅ cerrar bottom sheet (ctx del bottom sheet, no el dialog)
                            Navigator.pop(ctx);

                            _showSnack('Perfil actualizado correctamente');
                          } catch (e) {
                            if (dialogContext != null) {
                              Navigator.pop(dialogContext!);
                            }
                            _showSnack('Error al actualizar');
                          } finally {
                            setLocal(() => saving = false);
                          }
                        },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _navy,
                      foregroundColor: Colors.white,
                      elevation: 3,
                      shadowColor: _navy.withOpacity(0.35),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: saving
                        ? const SizedBox(
                            width: 20, height: 20,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Text('Guardar cambios',
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

  void _confirmarCerrarSesion() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Cerrar sesión',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: _navy)),
        content: const Text(
            '¿Seguro que deseas cerrar sesión? Tendrás que volver a iniciar sesión para acceder.',
            style: TextStyle(color: _navy, fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // ← solo cierra el diálogo
            child: const Text('Cancelar', style: TextStyle(color: _gray)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(  // ← va al Login
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Cerrar sesión', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isError ? Icons.error_outline : Icons.check_circle_outline,
                size: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                msg,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? _red : _navy,
        behavior: SnackBarBehavior.floating,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ─── BUILD ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: _bg,
        body: Center(child: CircularProgressIndicator(color: _navy)),
      );
    }
    if (_user == null) {
      return const Scaffold(
        backgroundColor: _bg,
        body: Center(
          child: Text('No se encontró el usuario',
              style: TextStyle(color: _gray, fontSize: 15)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: _bg,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Perfil',
                      style: TextStyle(
                          fontSize: 34, fontWeight: FontWeight.w800, color: _navy)),
                  const SizedBox(height: 24),

                  // ── Card principal ──
                  _buildProfileCard(),
                  const SizedBox(height: 20),

                  // ── Ajustes ──
                  _buildLabel('Ajustes'),
                  const SizedBox(height: 10),
                  _buildSettings(),
                  const SizedBox(height: 20),

                  // ── Cerrar sesión ──
                  _buildLogoutBtn(),
                  const SizedBox(height: 12),

                  Center(
                    child: Text('TecnoCan v1.0.0',
                        style: TextStyle(
                            fontSize: 12, color: _gray.withOpacity(0.7))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── Widgets ──────────────────────────────────────────────────────────────

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 18,
              offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 100, height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _navy.withOpacity(0.15), width: 3),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/profile.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: _navyLight,
                  child: const Icon(Icons.person, size: 54, color: _navy),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),

          Text(_nombreCompleto,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w800, color: _navy)),
          const SizedBox(height: 4),
          const Text('Usuario TecnoCan',
              style: TextStyle(fontSize: 13, color: _gray)),
          const SizedBox(height: 20),

          _buildInfoTile(Icons.email_outlined, 'Correo', _user!.email),
          const SizedBox(height: 12),
          _buildInfoTile(Icons.calendar_today_outlined, 'Miembro desde',
              _formatFecha(_user!.createdAt)),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _abrirEditarPerfil,
              icon: const Icon(Icons.edit_rounded, size: 16),
              label: const Text('Editar perfil',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _navy,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                elevation: 3,
                shadowColor: _navy.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String emoji, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 6),
          Text(value,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w800, color: _navy)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 11, color: _gray)),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border),
      ),
      child: Column(
        children: [
          _settingsTile(
            Icons.notifications_outlined,
            'Notificaciones',
            subtitle: 'Alertas de alimentación y estado',
            trailing: Switch(
              value: _notifEnabled,
              onChanged: (v) => setState(() => _notifEnabled = v),
              activeColor: _navy,
            ),
          ),
          _divider(),
          _settingsTile(
            Icons.lock_outline_rounded,
            'Privacidad',
            subtitle: 'Gestión de datos y permisos',
            trailing: const Icon(Icons.chevron_right_rounded, color: _gray, size: 20),
            onTap: () => _showSnack('Próximamente disponible'),
          ),
          _divider(),
          _settingsTile(
            Icons.help_outline_rounded,
            'Ayuda y soporte',
            subtitle: 'Preguntas frecuentes y contacto',
            trailing: const Icon(Icons.chevron_right_rounded, color: _gray, size: 20),
            onTap: () => _showSnack('Próximamente disponible'),
          ),
        ],
      ),
    );
  }

  Widget _settingsTile(
    IconData icon,
    String title, {
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: _navyLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: _navy, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700, color: _navy)),
                  if (subtitle != null)
                    Text(subtitle,
                        style: const TextStyle(fontSize: 11, color: _gray)),
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutBtn() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _confirmarCerrarSesion,
        icon: const Icon(Icons.logout_rounded, size: 18, color: _red),
        label: const Text('Cerrar sesión',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _red)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          side: BorderSide(color: _red.withOpacity(0.4)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: _navy.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: _navy, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 11, color: _gray)),
                const SizedBox(height: 3),
                Text(value,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700, color: _navy)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) => Text(
        text,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w700, color: _navy),
      );

  Widget _divider() =>
      const Divider(height: 1, color: Color(0xFFECF2F8), indent: 16, endIndent: 16);

  Widget _sheetField(
    TextEditingController ctrl,
    String hint,
    IconData icon, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboard,
      style: const TextStyle(fontSize: 15, color: _navy, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            const TextStyle(color: Color(0xFFAFC3D5), fontWeight: FontWeight.w400),
        prefixIcon: Icon(icon, color: _gray, size: 20),
        filled: true,
        fillColor: _navyLight,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}