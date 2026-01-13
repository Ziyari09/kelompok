import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:kelompok/Uranus.dart';
import 'planetbumidanmars.dart';

void main() {
  runApp(const SolarSystemApp());
}

class SolarSystemApp extends StatelessWidget {
  const SolarSystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
  // =======================
  // MENU UTAMA
  // =======================
  final List<String> mainMenu = [
    "Solar System",
    "Mercury & Venus",
    "Bumi & Mars",
    "Jupiter & Saturn",
    "Uranus & Neptune",
  ];

  String selectedMenu = "Solar System";
  bool isMenuVisible = true;

  // =======================
  // ANIMATION CONTROLLERS
  // =======================
  late List<AnimationController> planetControllers;

  @override
  void initState() {
    super.initState();

    // Buat controller untuk setiap planet dengan kecepatan berbeda
    planetControllers = List.generate(8, (index) {
      final controller = AnimationController(
        vsync: this,
        duration: Duration(
          seconds: 5 + index * 3,
        ), // Semakin jauh, semakin lambat
      );
      controller.repeat();
      return controller;
    });
  }

  @override
  void dispose() {
    for (var controller in planetControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        // =======================
        // MOBILE
        // =======================
        if (isMobile) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text("Solar System"), // FIXED: Hardcoded title
            ),
            drawer: _drawerMenu(),
            body: _content(),
          );
        }

        // =======================
        // WEB / DESKTOP
        // =======================
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(isMenuVisible ? Icons.menu_open : Icons.menu),
              onPressed: () {
                setState(() {
                  isMenuVisible = !isMenuVisible;
                });
              },
            ),
            title: const Text("Solar System"), // FIXED: Hardcoded title
          ),
          body: Row(
            children: [
              if (isMenuVisible) _sideBar(),
              Expanded(child: _content()),
            ],
          ),
        );
      },
    );
  }

  // =======================
  // SIDEBAR (WEB)
  // =======================
  Widget _sideBar() {
    return Container(
      width: 260,
      color: const Color(0xFF111111),
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "MENU",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(color: Colors.grey),

          ...mainMenu.map((menu) {
            final selected = menu == selectedMenu;

            return ListTile(
              title: Text(
                menu,
                style: TextStyle(
                  color: selected ? Colors.greenAccent : Colors.white,
                ),
              ),
              onTap: () {
                // FIXED: Jangan ubah selectedMenu untuk navigasi
                // setState(() {
                //   selectedMenu = menu;
                // });

                // =====================================
                // PINDAH PAGE
                // =====================================
                if (menu == "Uranus & Neptune") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => UranusPage()),
                  );
                } else if (menu == "Bumi & Mars") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EncyclopediaHome()),
                  );
                }
                // Tambahkan navigasi untuk menu lain jika diperlukan
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  // =======================
  // DRAWER (MOBILE)
  // =======================
  Widget _drawerMenu() {
    return Drawer(
      backgroundColor: const Color(0xFF111111),
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              "MENU",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ...mainMenu.map((menu) {
            final selected = menu == selectedMenu;

            return ListTile(
              title: Text(
                menu,
                style: TextStyle(
                  color: selected ? Colors.greenAccent : Colors.white,
                ),
              ),
              onTap: () {
                // FIXED: Jangan ubah selectedMenu untuk navigasi
                // setState(() {
                //   selectedMenu = menu;
                // });
                Navigator.pop(context);

                // =====================================
                // PINDAH PAGE
                // =====================================
                if (menu == "Uranus & Neptune") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => UranusPage()),
                  );
                } else if (menu == "Bumi & Mars") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EncyclopediaHome()),
                  );
                }
                // Tambahkan navigasi untuk menu lain jika diperlukan
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  // =======================
  // KONTEN UTAMA - SOLAR SYSTEM
  // =======================
  Widget _content() {
    return Stack(
      children: [
        // Background Alam Semesta
        Positioned.fill(
          child: Image.network(
            'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?w=1920',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Fallback dengan background gradient bintang
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF000428),
                      Color(0xFF004e92),
                      Colors.black,
                    ],
                  ),
                ),
                child: CustomPaint(painter: StarsPainter()),
              );
            },
          ),
        ),

        // Overlay gelap agar planet lebih terlihat
        Positioned.fill(child: Container(color: Colors.black.withOpacity(0.4))),

        // Animasi Solar System
        Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Sesuaikan ukuran dengan layar
              final size = constraints.maxWidth < constraints.maxHeight
                  ? constraints.maxWidth * 0.95
                  : constraints.maxHeight * 0.95;
              return SolarSystemAnimation(
                controllers: planetControllers,
                size: size,
              );
            },
          ),
        ),

        // Teks Overlay
        Positioned(
          top: 40,
          left: 0,
          right: 0,
          child: Column(
            children: [
              const Text(
                "Solar System",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =======================
// SOLAR SYSTEM ANIMATION
// =======================
class SolarSystemAnimation extends StatelessWidget {
  final List<AnimationController> controllers;
  final double size;

  // URL gambar matahari (bisa diganti)
  final String sunImageUrl;

  const SolarSystemAnimation({
    super.key,
    required this.controllers,
    required this.size,
    this.sunImageUrl =
        'https://images.unsplash.com/photo-1614642264762-d0a3b8bf3700?w=400',
  });

  @override
  Widget build(BuildContext context) {
    // Skala untuk menyesuaikan dengan ukuran layar
    final scale = size / 600;

    // Data planet: [jarak orbit, ukuran, warna, nama]
    final planets = [
      [70.0 * scale, 6.0 * scale, Colors.grey, 'Mercury'],
      [105.0 * scale, 9.0 * scale, Colors.orange.shade300, 'Venus'],
      [145.0 * scale, 10.0 * scale, Colors.blue, 'Earth'],
      [190.0 * scale, 8.0 * scale, Colors.red.shade400, 'Mars'],
      [250.0 * scale, 18.0 * scale, Colors.orange.shade100, 'Jupiter'],
      [310.0 * scale, 15.0 * scale, Colors.amber.shade200, 'Saturn'],
      [360.0 * scale, 12.0 * scale, Colors.cyan.shade200, 'Uranus'],
      [410.0 * scale, 12.0 * scale, Colors.blue.shade700, 'Neptune'],
    ];

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Orbit lines (elips)
          ...planets.map((planet) {
            return CustomPaint(
              size: Size(size, size),
              painter: OrbitPainter(radius: planet[0] as double),
            );
          }).toList(),

          // Matahari di tengah (dengan gambar)
          Container(
            width: 100 * scale,
            height: 100 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.8),
                  blurRadius: 40 * scale,
                  spreadRadius: 15 * scale,
                ),
                BoxShadow(
                  color: Colors.yellow.withOpacity(0.5),
                  blurRadius: 60 * scale,
                  spreadRadius: 25 * scale,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                sunImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback jika gambar gagal dimuat
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.yellow.shade200,
                          Colors.orange,
                          Colors.deepOrange,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.wb_sunny,
                        color: Colors.white,
                        size: 30 * scale,
                      ),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.yellow.shade200,
                          Colors.orange,
                          Colors.deepOrange,
                        ],
                      ),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Planet-planet bergerak
          ...List.generate(planets.length, (index) {
            final planet = planets[index];
            final orbitRadius = planet[0] as double;
            final planetSize = planet[1] as double;
            final planetColor = planet[2] as Color;
            final planetName = planet[3] as String;

            return AnimatedBuilder(
              animation: controllers[index],
              builder: (context, child) {
                final angle = controllers[index].value * 2 * math.pi;
                final x = orbitRadius * math.cos(angle);
                final y = orbitRadius * math.sin(angle);

                return Transform.translate(
                  offset: Offset(x, y),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: planetSize,
                        height: planetSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: planetColor,
                          boxShadow: [
                            BoxShadow(
                              color: planetColor.withOpacity(0.6),
                              blurRadius: 8 * scale,
                              spreadRadius: 2 * scale,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4 * scale),
                      Text(
                        planetName,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10 * scale,
                          fontWeight: FontWeight.w300,
                          shadows: const [
                            Shadow(color: Colors.black, blurRadius: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

// =======================
// ORBIT PAINTER (ELIPS)
// =======================
class OrbitPainter extends CustomPainter {
  final double radius;

  OrbitPainter({required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final center = Offset(size.width / 2, size.height / 2);

    // Gambar orbit elips
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =======================
// STARS PAINTER (BINTANG-BINTANG)
// =======================
class StarsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final random = math.Random(
      42,
    ); // Seed tetap agar bintang tidak berubah posisi

    // Gambar 300 bintang random
    for (int i = 0; i < 300; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final starSize = random.nextDouble() * 2.5 + 0.5;

      paint.color = Colors.white.withOpacity(random.nextDouble() * 0.6 + 0.4);
      canvas.drawCircle(Offset(x, y), starSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
