import 'dart:convert';
import 'package:http/http.dart' as http;

class WeightService {
  final String baseUrl;

  WeightService(this.baseUrl); // ej: http://192.168.4.1

  Future<double?> getPeso() async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/peso'));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return (data['peso'] as num).toDouble();
      }
    } catch (e) {
      return null;
    }

    return null;
  }
}