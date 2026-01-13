import 'package:flutter/material.dart';
import 'neptune_detail.dart'; // Import file detail yang sudah dibuat

void main() {
  runApp(const NeptuneApp());
}

class NeptuneApp extends StatelessWidget {
  const NeptuneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planet Neptunus',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema biru untuk Neptunus
        scaffoldBackgroundColor: Colors.black, // Latar belakang gelap seperti ruang angkasa
      ),
      home: const NeptuneHomePage(),
    );
  }
}

class NeptuneHomePage extends StatefulWidget {
  const NeptuneHomePage({super.key});

  @override
  State<NeptuneHomePage> createState() => _NeptuneHomePageState();
}

class _NeptuneHomePageState extends State<NeptuneHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planet Neptunus'),
        backgroundColor: Colors.black, // Mengubah background AppBar menjadi hitam agar sama dengan body
        elevation: 0, // Menghilangkan bayangan agar terlihat menyatu
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Gambar Neptunus (gunakan gambar dari assets atau URL)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animation.value * 2 * 3.14159, // Rotasi penuh
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/5/56/Neptune_Full.jpg', // Gambar Neptunus dari Wikimedia
                    width: 200,
                    height: 200,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Neptunus: Planet Terjauh',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Neptunus adalah planet gas raksasa dengan warna biru yang indah. '
                'Ditemukan pada 1846, ia memiliki angin terkuat di Tata Surya dan satelit Triton.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman detail Neptunus
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NeptunusDetailPage()),
                );
              },
              child: const Text('Pelajari Lebih Lanjut'),
            ),
          ],
        ),
      ),
    );
  }
}