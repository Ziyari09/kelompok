import 'package:flutter/material.dart';

class NeptunusDetailPage extends StatelessWidget {
  const NeptunusDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Neptunus'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Neptunus
            Center(
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/5/56/Neptune_Full.jpg',
                width: 250,
                height: 250,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Fakta Lengkap tentang Neptunus',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Neptunus adalah planet kedelapan dari Matahari dan planet terjauh di Tata Surya. '
              'Ditemukan pada tahun 1846 oleh astronom Johann Galle, Neptunus dikenal dengan warna biru yang menakjubkan '
              'karena adanya metana di atmosfernya yang menyerap cahaya merah.',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 20),
            // Tabel Data
            const Text(
              'Data Utama:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Table(
              border: TableBorder.all(color: Colors.white54),
              children: const [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Jarak dari Matahari', style: TextStyle(color: Colors.white)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('4.5 miliar km', style: TextStyle(color: Colors.white70)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Diameter', style: TextStyle(color: Colors.white)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('49.244 km', style: TextStyle(color: Colors.white70)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Massa', style: TextStyle(color: Colors.white)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('17 kali massa Bumi', style: TextStyle(color: Colors.white70)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Suhu Permukaan', style: TextStyle(color: Colors.white)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('-200°C', style: TextStyle(color: Colors.white70)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Satelit Utama', style: TextStyle(color: Colors.white)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Triton (14 satelit total)', style: TextStyle(color: Colors.white70)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Fakta Menarik:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '- Neptunus memiliki angin terkuat di Tata Surya, mencapai 2.100 km/jam.\n'
              '- Satelit Triton bergerak mundur (retrograde), menunjukkan ia mungkin ditangkap dari sabuk Kuiper.\n'
              '- Neptunus memiliki cincin tipis yang sulit terlihat.',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Kembali ke halaman utama
                },
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}