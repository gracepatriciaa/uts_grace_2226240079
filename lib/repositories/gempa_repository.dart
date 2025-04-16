import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/gempa_model.dart';

class GempaRepository {
  final String apiUrl = 'https://data.bmkg.go.id/DataMKG/TEWS/autogempa.json';

  // Helper untuk URL shakemap
  String getShakemapUrl(String filename) {
    if (filename.isEmpty) return '';
    return 'https://data.bmkg.go.id/DataMKG/TEWS/$filename';
  }

  Future<Gempa> fetchGempaTerakhir() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final gempaData = jsonData['Infogempa']['gempa'] ?? {};

        // Pastikan field ada
        return Gempa.fromJson({
          ...gempaData,
          'Shakemap': getShakemapUrl(gempaData['Shakemap'] ?? ''),
        });
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error saat mengambil data: $e');
    }
  }
}
