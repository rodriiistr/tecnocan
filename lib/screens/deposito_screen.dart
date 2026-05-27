import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DepositoScreen extends StatefulWidget {
  const DepositoScreen({super.key});

  @override
  State<DepositoScreen> createState() => _DepositoScreenState();
}

class _DepositoScreenState extends State<DepositoScreen> {
  static const Color navy = Color(0xFF1A3E6E);
  static const Color bg = Color(0xFFF5F8FC);

  final String baseUrl = "http://192.168.4.1";

  double croqueta = 0.0;
  double agua = 0.0;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _cargarPeso();

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return false;
      await _cargarPeso();
      return true;
    });
  }

  // =========================
  // LECTURA DE PESOS
  // =========================
  Future<void> _cargarPeso() async {
    setState(() => _loading = true);

    try {
      final res = await http.get(Uri.parse('$baseUrl/pesos'));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        print(data);

        setState(() {
          final pesoCroqueta = (data['peso1'] as num).toDouble();
          final pesoAgua = (data['peso2'] as num).toDouble();

          const max = 10.0;

          croqueta = (pesoCroqueta / max).clamp(0.0, 1.0);
          agua = (pesoAgua / max).clamp(0.0, 1.0);
        });
      }
    } catch (e) {
      print("ERROR: $e");
    }

    setState(() => _loading = false);
  }

  // =========================
  // 🔥 CONTROL DE LED POR GPIO
  // =========================
  Future<void> _toggleGPIO4(bool on) async {
    try {
      final url = Uri.parse(
        on
            ? '$baseUrl/gpio4/on'
            : '$baseUrl/gpio4/off',
      );

      final res = await http.get(url);

      final data = jsonDecode(res.body);

      print(data);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(data['mensaje'] ?? 'OK'),
        ),
      );
    } catch (e) {
      print("ERROR GPIO: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Depósitos',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: navy,
                ),
              ),

              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 330,
                      child: Image.asset('assets/prototipo-frontal.png'),
                    ),

                    const SizedBox(height: 28),

                    Row(
                      children: [
                        Expanded(
                          child: _buildIndicator(
                            title: 'Croqueta',
                            percent: croqueta,
                            color: const Color(0xFF9ED0FF),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildIndicator(
                            title: 'Agua',
                            percent: agua,
                            color: navy,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // =========================
                    // 🔥 BOTONES GPIO 4 y 5
                    // =========================
                    Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _miniButton(
                            Icons.lightbulb,
                            "GPIO 4 ON",
                            () => _toggleGPIO4(true),
                          ),
                          _miniButton(
                            Icons.lightbulb_outline,
                            "GPIO 4 OFF",
                            () => _toggleGPIO4(false),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator({
    required String title,
    required double percent,
    required Color color,
  }) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 18),
        SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: percent,
                strokeWidth: 10,
                backgroundColor: const Color(0xFFE7EDF5),
                valueColor: AlwaysStoppedAnimation(color),
              ),
              Text('${(percent * 100).toInt()}%'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _miniButton(IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: navy.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: navy),
            const SizedBox(width: 6),
            Text(text, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}