import 'package:http/http.dart' as http;

class DeviceDiscovery {
  static const String esp32Ip = "192.168.4.1";

  Future<String?> findEsp32() async {
    try {
      final url = Uri.parse("http://$esp32Ip/estado");

      final res = await http
          .get(url)
          .timeout(const Duration(seconds: 2));

      if (res.statusCode == 200) {
        return esp32Ip;
      }
    } catch (_) {}

    return null;
  }
}