class Gempa {
  final String tanggal;
  final String jam;
  final DateTime dateTime;
  final String coordinates;
  final String lintang;
  final String bujur;
  final String magnitude;
  final String kedalaman;
  final String wilayah;
  final String potensi;
  final String dirasakan;
  final String shakemapUrl;

  Gempa({
    required this.tanggal,
    required this.jam,
    required this.dateTime,
    required this.coordinates,
    required this.lintang,
    required this.bujur,
    required this.magnitude,
    required this.kedalaman,
    required this.wilayah,
    required this.potensi,
    required this.dirasakan,
    required this.shakemapUrl,
  });

  factory Gempa.fromJson(Map<String, dynamic> json) {
    return Gempa(
      tanggal: json['Tanggal'] ?? '',
      jam: json['Jam'] ?? '',
      dateTime:
          DateTime.parse(json['DateTime'] ?? DateTime.now().toIso8601String()),
      coordinates: json['Coordinates'] ?? '',
      lintang: json['Lintang'] ?? '',
      bujur: json['Bujur'] ?? '',
      magnitude: json['Magnitude'] ?? '',
      kedalaman: json['Kedalaman'] ?? '',
      wilayah: json['Wilayah'] ?? '',
      potensi: json['Potensi'] ?? '',
      dirasakan: json['Dirasakan'] ?? '',
      shakemapUrl: json['Shakemap'] ?? '',
    );
  }
}
