import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mahasiswa/models/gempa_model.dart';

class GempaRepository {
  final String apiUrl = 'https://data.bmkg.go.id/DataMKG/TEWS/autogempa.json';

  Future<Gempa> fetchGempaTerakhir() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final gempaData = jsonData['Infogempa']['gempa'];
      return Gempa.fromJson(gempaData);
    } else {
      throw Exception('Gagal memuat data gempa');
    }
  }
}
