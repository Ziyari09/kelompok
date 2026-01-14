import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const EksploratorPlanetApp());
}

class EksploratorPlanetApp extends StatelessWidget {
  const EksploratorPlanetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eksplorasi Planet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      home: const BerandaEksploratorPlanet(),
    );
  }
}

class BerandaEksploratorPlanet extends StatefulWidget {
  const BerandaEksploratorPlanet({Key? key}) : super(key: key);

  @override
  State<BerandaEksploratorPlanet> createState() => _BerandaEksploratorPlanetState();
}

class _BerandaEksploratorPlanetState extends State<BerandaEksploratorPlanet>
    with TickerProviderStateMixin {
  String selectedPlanet = 'mercury';
  late AnimationController _rotationController;
  late AnimationController _floatController;
  late AnimationController _planetRotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _floatController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);

    _planetRotationController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _floatController.dispose();
    _planetRotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final planet = _getPlanetData(selectedPlanet);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          _buildBackground(screenWidth),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  // Header
                  _buildHeader(),
                  const SizedBox(height: 30),

                  // Planet Selector
                  _buildPlanetSelector(),
                  const SizedBox(height: 30),

                  // Planet Info
                  _buildPlanetInfo(planet),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(double screenWidth) {
    return Stack(
      children: [
        // Base gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1a0633),
                Color(0xFF0a1929),
                Color(0xFF1a0a29),
              ],
            ),
          ),
        ),

        // Black Hole - Left (Mobile optimized)
        Positioned(
          top: 40,
          left: -40,
          child: AnimatedBuilder(
            animation: _floatController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  sin(_floatController.value * 2 * pi) * 10,
                  cos(_floatController.value * 2 * pi) * 8,
                ),
                child: child,
              );
            },
            child: _buildBlackHole(120),
          ),
        ),

        // Sun - Right (Mobile optimized)
        Positioned(
          top: 60,
          right: -30,
          child: AnimatedBuilder(
            animation: _floatController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  0,
                  sin(_floatController.value * pi) * 15,
                ),
                child: child,
              );
            },
            child: _buildSun(110),
          ),
        ),

        // Stars
        ..._buildStars(screenWidth),

        // Shooting Stars
        ..._buildShootingStars(screenWidth),
      ],
    );
  }

  Widget _buildBlackHole(double size) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationController.value * 2 * pi,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.black,
                  Colors.purple.withOpacity(0.5),
                  Colors.blue.withOpacity(0.3),
                  Colors.cyan.withOpacity(0.1),
                ],
                stops: const [0.4, 0.6, 0.8, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.4),
                  blurRadius: 40,
                  spreadRadius: 8,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSun(double size) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [
                Color(0xFFFFF9E5),
                Color(0xFFFFD54F),
                Color(0xFFFF9800),
                Color(0xFFFF5722),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.5),
                blurRadius: 60,
                spreadRadius: 20,
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildStars(double screenWidth) {
    final random = Random(42);
    return List.generate(100, (index) {
      return Positioned(
        top: random.nextDouble() * 1200,
        left: random.nextDouble() * screenWidth,
        child: Container(
          width: random.nextDouble() * 2.5 + 1,
          height: random.nextDouble() * 2.5 + 1,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(random.nextDouble() * 0.5 + 0.5),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.4),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      );
    });
  }

  List<Widget> _buildShootingStars(double screenWidth) {
    return List.generate(3, (index) {
      return Positioned(
        top: 80.0 + (index * 150),
        right: -50,
        child: TweenAnimationBuilder<double>(
          key: ValueKey(index),
          tween: Tween(begin: 1.0, end: 0.0),
          duration: Duration(seconds: 3 + index),
          onEnd: () {
            // Trigger rebuild to restart animation
            if (mounted) {
              setState(() {});
            }
          },
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(-(screenWidth + 100) * (1 - value), 0),
              child: Opacity(
                opacity: value,
                child: Container(
                  width: 80,
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Colors.white,
                        Colors.blue.shade200,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildHeader() {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xFFFFD54F),
              Color(0xFFFF9800),
              Color(0xFFFF5722),
            ],
          ).createShader(bounds),
          child: const Text(
            'Planet Pedia',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Jelajahi Misteri Merkurius dan Venus',
          style: TextStyle(
            fontSize: 14,
            color: Colors.orange.shade200,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPlanetSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPlanetButton('mercury', '☿', 'Merkurius',
            [Colors.grey.shade400, Colors.grey.shade600]),
        const SizedBox(width: 30),
        _buildPlanetButton('venus', '♀', 'Venus',
            [Colors.yellow.shade300, Colors.orange.shade500]),
      ],
    );
  }

  Widget _buildPlanetButton(
      String id, String icon, String name, List<Color> colors) {
    final isSelected = selectedPlanet == id;

    return GestureDetector(
      onTap: () => setState(() => selectedPlanet = id),
      child: AnimatedScale(
        scale: isSelected ? 1.0 : 0.85,
        duration: const Duration(milliseconds: 300),
        child: AnimatedOpacity(
          opacity: isSelected ? 1.0 : 0.6,
          duration: const Duration(milliseconds: 300),
          child: Column(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: colors[0], width: 3)
                      : null,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: colors[0].withOpacity(0.5),
                            blurRadius: 15,
                            spreadRadius: 3,
                          ),
                        ]
                      : [],
                ),
                child: ClipOval(
                  child: Image.network(
                    id == 'mercury'
                        ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Mercury_in_true_color.jpg/800px-Mercury_in_true_color.jpg'
                        : 'https://upload.wikimedia.org/wikipedia/commons/8/85/Venus_globe.jpg',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: colors,
                          ),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: colors,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            icon,
                            style: const TextStyle(
                              fontSize: 45,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanetInfo(DataPlanet planet) {
    return Column(
      children: [
        // Description
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    planet.icon,
                    style: const TextStyle(fontSize: 28),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      planet.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                planet.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.orange.shade100,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Facts Grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.95,
          children: planet.facts
              .map((fact) => Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          fact.title,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange.shade200,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          fact.value,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          fact.detail,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade300,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 20),

        // Features
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.terrain, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Karakteristik Unik',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ...planet.features.asMap().entries.map((entry) {
                final index = entry.key;
                final feature = entry.value;
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index < planet.features.length - 1 ? 14 : 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange.shade200,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        feature.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade200,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Fun Facts
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.shade600.withOpacity(0.2),
                Colors.yellow.shade600.withOpacity(0.2),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.orange.shade400.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.lightbulb, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Fakta Menarik',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ...planet.funFacts.map((fact) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('✨', style: TextStyle(fontSize: 18)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            fact,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.orange.shade50,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  DataPlanet _getPlanetData(String id) {
    if (id == 'mercury') {
      return DataPlanet(
        name: 'Merkurius',
        icon: '⚫',
        description:
            'Planet terdekat dengan Matahari dan planet terkecil di Tata Surya',
        gradientColors: [Colors.grey.shade400, Colors.grey.shade700],
        facts: [
          FaktaPlanet('Diameter', '4.879 km', 'Hanya sedikit lebih besar dari Bulan'),
          FaktaPlanet('Suhu', '-173°C hingga 427°C',
              'Variasi suhu terbesar di Tata Surya'),
          FaktaPlanet('Rotasi', '59 hari Bumi', 'Berputar sangat lambat pada porosnya'),
          FaktaPlanet('Orbit', '88 hari Bumi', 'Tahun tercepat di Tata Surya'),
        ],
        features: [
          FiturPlanet(
            'Tidak Ada Atmosfer',
            'Merkurius hampir tidak memiliki atmosfer, sehingga tidak dapat menahan panas. Ini menyebabkan perbedaan suhu ekstrem antara siang dan malam.',
          ),
          FiturPlanet(
            'Kawah Besar',
            'Permukaan dipenuhi kawah akibat tumbukan asteroid dan komet. Kawah Caloris Basin adalah salah satu yang terbesar dengan diameter 1.550 km.',
          ),
          FiturPlanet(
            'Inti Besi Besar',
            'Memiliki inti besi raksasa yang mencakup sekitar 75% dari diameter planet, membuat Merkurius sangat padat.',
          ),
        ],
        funFacts: [
          'Sehari di Merkurius (dari matahari terbit ke terbit) = 176 hari Bumi',
          'Gravitasinya hanya 38% dari gravitasi Bumi',
          'Dinamai dari dewa Romawi pembawa pesan yang dikenal karena kecepatannya',
        ],
      );
    } else {
      return DataPlanet(
        name: 'Venus',
        icon: '🌕',
        description:
            'Planet paling terang di langit dan sering disebut "Bintang Fajar" atau "Bintang Senja"',
        gradientColors: [Colors.yellow.shade300, Colors.orange.shade600],
        facts: [
          FaktaPlanet('Diameter', '12.104 km', 'Hampir sama besar dengan Bumi'),
          FaktaPlanet('Suhu Permukaan', '462°C', 'Planet terpanas di Tata Surya'),
          FaktaPlanet(
              'Rotasi', '243 hari Bumi', 'Berputar berlawanan arah jarum jam'),
          FaktaPlanet('Tekanan', '92x Bumi', 'Seperti berada 900m di bawah laut'),
        ],
        features: [
          FiturPlanet(
            'Atmosfer Tebal',
            'Atmosfer Venus 96% terdiri dari CO₂ dengan awan asam sulfat. Efek rumah kaca ekstrem membuat Venus lebih panas dari Merkurius meskipun lebih jauh dari Matahari.',
          ),
          FiturPlanet(
            'Rotasi Retrograde',
            'Venus berputar berlawanan arah dengan planet lain. Matahari terbit di barat dan terbenam di timur. Satu hari Venus lebih lama dari satu tahunnya!',
          ),
          FiturPlanet(
            'Gunung Berapi',
            'Memiliki lebih dari 1.600 gunung berapi besar. Maxwell Montes adalah gunung tertinggi dengan ketinggian 11 km.',
          ),
        ],
        funFacts: [
          'Satu hari Venus (243 hari Bumi) lebih panjang dari setahunnya (225 hari Bumi)',
          'Tidak memiliki bulan atau cincin',
          'Dinamai dari dewi cinta dan kecantikan Romawi',
        ],
      );
    }
  }
}

class DataPlanet {
  final String name;
  final String icon;
  final String description;
  final List<Color> gradientColors;
  final List<FaktaPlanet> facts;
  final List<FiturPlanet> features;
  final List<String> funFacts;

  DataPlanet({
    required this.name,
    required this.icon,
    required this.description,
    required this.gradientColors,
    required this.facts,
    required this.features,
    required this.funFacts,
  });
}

class FaktaPlanet {
  final String title;
  final String value;
  final String detail;

  FaktaPlanet(this.title, this.value, this.detail);
}

class FiturPlanet {
  final String title;
  final String description;

  FiturPlanet(this.title, this.description);
}