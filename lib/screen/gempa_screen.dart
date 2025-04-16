import 'package:flutter/material.dart';
import 'package:uts_grace_2226240079/models/gempa_model.dart';
import 'package:uts_grace_2226240079/repositories/gempa_repository.dart';

class GempaScreen extends StatefulWidget {
  const GempaScreen({super.key});

  @override
  State<GempaScreen> createState() => _GempaScreenState();
}

class _GempaScreenState extends State<GempaScreen> {
  final GempaRepository _repository = GempaRepository();
  late Future<Gempa> _futureGempa;

  @override
  void initState() {
    super.initState();
    _futureGempa = _repository.fetchGempaTerakhir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Gempa Terkini BMKG'),
        centerTitle: true,
      ),
      body: FutureBuilder<Gempa>(
        future: _futureGempa,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Tidak ada data gempa'));
          }

          final gempa = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Gempa Terkini',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 20),
                _buildInfoRow('Tanggal', gempa.tanggal),
                _buildInfoRow('Jam', gempa.jam),
                _buildInfoRow('Koordinat', gempa.coordinates),
                _buildInfoRow('Lintang', gempa.lintang),
                _buildInfoRow('Bujur', gempa.bujur),
                _buildInfoRow('Magnitude', gempa.magnitude),
                _buildInfoRow('Kedalaman', gempa.kedalaman),
                _buildInfoRow('Wilayah', gempa.wilayah),
                _buildInfoRow('Potensi', gempa.potensi),
                _buildInfoRow('Dirasakan', gempa.dirasakan),
                const SizedBox(height: 20),
                if (gempa.shakemapUrl.isNotEmpty)
                  Center(
                    child: Column(
                      children: [
                        const Text('Peta Guncangan (Shakemap)'),
                        const SizedBox(height: 10),
                        Image.network(
                          'https://data.bmkg.go.id/DataMKG/TEWS/${gempa.shakemapUrl}',
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Gambar tidak tersedia');
                          },
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureGempa = _repository.fetchGempaTerakhir();
                      });
                    },
                    child: const Text('Refresh Data'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
