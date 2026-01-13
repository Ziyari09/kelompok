import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlanetPedia',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF000000),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MenuPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EncyclopediaHome extends StatefulWidget {
  const EncyclopediaHome({Key? key}) : super(key: key);

  @override
  State<EncyclopediaHome> createState() => _EncyclopediaHomeState();
}

class _EncyclopediaHomeState extends State<EncyclopediaHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const PlanetDetailPage(planetType: PlanetType.earth),
    const PlanetDetailPage(planetType: PlanetType.mars),
    const ComparisonPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _buildNASAHeader(),
          Expanded(child: _pages[_selectedIndex]),
          _buildNASANav(),
        ],
      ),
    );
  }

  Widget _buildNASAHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Planetpedia Logo
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0f3460), Color(0xFF16213e)],
                  ),
                  border: Border.all(color: const Color(0xFF4a5568), width: 2),
                ),
                child: const Icon(
                  Icons.public,
                  size: 32,
                  color: Color(0xFF64b5f6),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PLANETPEDIA',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFe0e0e0),
                      letterSpacing: 2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0f3460),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Text(
                      'Eksplorasi Tata Surya',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF64b5f6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF4a5568)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'ENSIKLOPEDIA',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF9ca3af),
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFF4a5568).withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNASANav() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a2e),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0f3460).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _buildNavButton(0, 'BUMI', Icons.public),
            Container(width: 1, height: 40, color: const Color(0xFF4a5568)),
            _buildNavButton(1, 'MARS', Icons.circle_outlined),
            Container(width: 1, height: 40, color: const Color(0xFF4a5568)),
            _buildNavButton(2, 'BANDINGKAN', Icons.compare_arrows),
            Container(width: 1, height: 40, color: const Color(0xFF4a5568)),
            _buildMenuButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(int index, String label, IconData icon) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => setState(() => _selectedIndex = index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0f3460) : Colors.transparent,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? const Color(0xFF64b5f6)
                      : const Color(0xFF6b7280),
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFF64b5f6)
                        : const Color(0xFF6b7280),
                    fontSize: 11,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton() {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Fungsi untuk kembali ke menu
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.home_outlined,
                  color: const Color(0xFF6b7280),
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  'MENU',
                  style: TextStyle(
                    color: const Color(0xFF6b7280),
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum PlanetType { earth, mars }

class PlanetDetailPage extends StatelessWidget {
  final PlanetType planetType;

  const PlanetDetailPage({Key? key, required this.planetType})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isEarth = planetType == PlanetType.earth;
    final planetData = isEarth ? earthData : marsData;

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(planetData, isEarth),
          _buildQuickFacts(planetData, isEarth),
          ...planetData['sections']
              .map<Widget>(
                (section) =>
                    _buildSection(section['title'], section['items'], isEarth),
              )
              .toList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeroSection(Map<String, dynamic> data, bool isEarth) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            isEarth
                ? const Color(0xFF1a1a2e).withOpacity(0.5)
                : const Color(0xFF2d1b1b).withOpacity(0.5),
            Colors.black,
          ],
        ),
      ),
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: isEarth
                      ? const Color(0xFF64b5f6).withOpacity(0.3)
                      : const Color(0xFFc77a5c).withOpacity(0.3),
                  blurRadius: 50,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: isEarth
                          ? [
                              const Color(0xFF64b5f6),
                              const Color(0xFF2196f3),
                              const Color(0xFF1565c0),
                            ]
                          : [
                              const Color(0xFFc77a5c),
                              const Color(0xFF9c5a3c),
                              const Color(0xFF6b3a2a),
                            ],
                    ),
                  ),
                ),
                // Gambar Planet dari URL
                ClipOval(
                  child: Image.network(
                    isEarth
                        ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/The_Blue_Marble_%28remastered%29.jpg/1200px-The_Blue_Marble_%28remastered%29.jpg'
                        : 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/OSIRIS_Mars_true_color.jpg/1200px-OSIRIS_Mars_true_color.jpg',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                          color: isEarth
                              ? const Color(0xFF64b5f6)
                              : const Color(0xFFc77a5c),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          isEarth ? Icons.public : Icons.circle,
                          size: 120,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Text(
            data['name'].toString().toUpperCase(),
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Color(0xFFe0e0e0),
              letterSpacing: 4,
              height: 1,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF0f3460),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              data['designation'],
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF9ca3af),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFacts(Map<String, dynamic> data, bool isEarth) {
    final quickFacts = data['sections'][0]['items'];
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a2e).withOpacity(0.5),
        border: Border.all(
          color: isEarth
              ? const Color(0xFF64b5f6).withOpacity(0.3)
              : const Color(0xFFc77a5c).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                color: isEarth
                    ? const Color(0xFF64b5f6)
                    : const Color(0xFFc77a5c),
              ),
              const SizedBox(width: 10),
              const Text(
                'FAKTA SINGKAT',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFe0e0e0),
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...quickFacts.map<Widget>(
            (fact) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isEarth
                          ? const Color(0xFF64b5f6)
                          : const Color(0xFFc77a5c),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 120,
                    child: Text(
                      fact['label'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9ca3af),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      fact['value'],
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFFe0e0e0),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<Map<String, String>> items,
    bool isEarth,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF1a1a2e), const Color(0xFF16213e)],
              ),
            ),
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFe0e0e0),
                letterSpacing: 2,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1a1a2e).withOpacity(0.3),
              border: Border.all(
                color: const Color(0xFF4a5568).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              children: items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['label']!,
                            style: TextStyle(
                              fontSize: 11,
                              color: isEarth
                                  ? const Color(0xFF64b5f6)
                                  : const Color(0xFFc77a5c),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['value']!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFFd1d5db),
                              height: 1.5,
                            ),
                          ),
                          if (item != items.last)
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: 1,
                              color: const Color(0xFF4a5568).withOpacity(0.2),
                            ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ComparisonPage extends StatelessWidget {
  const ComparisonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildComparisonHeader(),
          ...comparisonData.map((item) => _buildComparisonItem(item)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildComparisonHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Color(0xFF1a1a2e), Colors.black],
        ),
      ),
      child: Column(
        children: [
          const Text(
            'PERBANDINGAN PLANET',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xFFe0e0e0),
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildComparisonPlanet(
                'BUMI',
                const Color(0xFF64b5f6),
                Icons.public,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0f3460),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    'VS',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF9ca3af),
                    ),
                  ),
                ),
              ),
              _buildComparisonPlanet(
                'MARS',
                const Color(0xFFc77a5c),
                Icons.circle_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonPlanet(String name, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(colors: [color, color.withOpacity(0.5)]),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Icon(icon, size: 40, color: Colors.white.withOpacity(0.9)),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(color: const Color(0xFF0f3460)),
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9ca3af),
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonItem(Map<String, String> data) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(color: Color(0xFF0f3460)),
            child: Text(
              data['category']!.toUpperCase(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFFe0e0e0),
                letterSpacing: 2,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1a1a2e).withOpacity(0.5),
                    border: Border.all(
                      color: const Color(0xFF64b5f6).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF64b5f6),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'BUMI',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF64b5f6),
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        data['earth']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFd1d5db),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(width: 2, height: 100, color: const Color(0xFF4a5568)),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1a1a2e).withOpacity(0.5),
                    border: Border.all(
                      color: const Color(0xFFc77a5c).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFc77a5c),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'MARS',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFc77a5c),
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        data['mars']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFd1d5db),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Data untuk Bumi
final Map<String, dynamic> earthData = {
  'name': 'Bumi',
  'designation': 'PLANET KETIGA DARI MATAHARI',
  'sections': [
    {
      'title': 'Karakteristik Orbital',
      'items': [
        {'label': 'JARAK DARI MATAHARI', 'value': '149,6 juta km (1 AU)'},
        {'label': 'PERIODE ORBIT', 'value': '365,25 hari'},
        {'label': 'PERIODE ROTASI', 'value': '23,93 jam'},
        {'label': 'SATELIT ALAMI', 'value': '1 (Bulan)'},
      ],
    },
    {
      'title': 'Karakteristik Fisik',
      'items': [
        {'label': 'DIAMETER EKUATOR', 'value': '12.742 km'},
        {'label': 'MASSA', 'value': '5,97 × 10²⁴ kg'},
        {'label': 'GRAVITASI PERMUKAAN', 'value': '9,8 m/s²'},
        {'label': 'SUHU RATA-RATA', 'value': '15°C (59°F)'},
        {'label': 'KOMPOSISI PERMUKAAN', 'value': '71% air, 29% daratan'},
      ],
    },
    {
      'title': 'Data Atmosfer',
      'items': [
        {
          'label': 'KOMPOSISI',
          'value': '78% Nitrogen, 21% Oksigen, 1% gas lainnya',
        },
        {'label': 'TEKANAN PERMUKAAN', 'value': '101,3 kPa (1 atm)'},
        {
          'label': 'LAPISAN PELINDUNG',
          'value': 'Lapisan ozon melindungi dari radiasi UV berbahaya',
        },
      ],
    },
    {
      'title': 'Sorotan Misi',
      'items': [
        {
          'label': 'KELAYAKAN HUNI',
          'value': 'Satu-satunya planet yang diketahui memiliki kehidupan',
        },
        {
          'label': 'KEBERADAAN AIR',
          'value': 'Air cair melimpah dalam ketiga fase',
        },
        {
          'label': 'MAGNETOSFER',
          'value': 'Medan magnet kuat melindungi dari angin matahari',
        },
        {
          'label': 'AKTIVITAS GEOLOGIS',
          'value': 'Lempeng tektonik aktif, gunung berapi, dan gempa bumi',
        },
      ],
    },
  ],
};

// Data untuk Mars
final Map<String, dynamic> marsData = {
  'name': 'Mars',
  'designation': 'PLANET MERAH',
  'sections': [
    {
      'title': 'Karakteristik Orbital',
      'items': [
        {'label': 'JARAK DARI MATAHARI', 'value': '227,9 juta km (1,52 AU)'},
        {'label': 'PERIODE ORBIT', 'value': '687 hari Bumi'},
        {'label': 'PERIODE ROTASI', 'value': '24,6 jam (1 Sol)'},
        {'label': 'SATELIT ALAMI', 'value': '2 (Phobos dan Deimos)'},
      ],
    },
    {
      'title': 'Karakteristik Fisik',
      'items': [
        {'label': 'DIAMETER EKUATOR', 'value': '6.779 km (53% dari Bumi)'},
        {'label': 'MASSA', 'value': '6,39 × 10²³ kg (11% dari Bumi)'},
        {'label': 'GRAVITASI PERMUKAAN', 'value': '3,7 m/s² (38% dari Bumi)'},
        {'label': 'SUHU RATA-RATA', 'value': '-63°C (-81°F)'},
        {
          'label': 'KOMPOSISI PERMUKAAN',
          'value': 'Medan berbatu gurun dengan kawah tumbukan',
        },
      ],
    },
    {
      'title': 'Data Atmosfer',
      'items': [
        {'label': 'KOMPOSISI', 'value': '95% CO₂, 3% Nitrogen, 1,6% Argon'},
        {'label': 'TEKANAN PERMUKAAN', 'value': '0,6 kPa (0,6% dari Bumi)'},
        {
          'label': 'WARNA ATMOSFER',
          'value': 'Penampilan merah dari debu oksida besi',
        },
      ],
    },
    {
      'title': 'Sorotan Misi',
      'items': [
        {
          'label': 'OLYMPUS MONS',
          'value': 'Gunung berapi setinggi 21 km, terbesar di tata surya',
        },
        {
          'label': 'VALLES MARINERIS',
          'value': 'Sistem ngarai sepanjang 4.000 km',
        },
        {
          'label': 'TUTUP ES KUTUB',
          'value': 'Air beku dan karbon dioksida di kutub',
        },
        {
          'label': 'STATUS EKSPLORASI',
          'value': 'Beberapa rover dan orbiter aktif mempelajari planet ini',
        },
      ],
    },
  ],
};

// Data perbandingan
final List<Map<String, String>> comparisonData = [
  {
    'category': 'Ukuran & Skala',
    'earth': 'Diameter 12.742 km, hampir dua kali lebih besar dari Mars',
    'mars': 'Diameter 6.779 km, sekitar setengah ukuran Bumi',
  },
  {
    'category': 'Gravitasi',
    'earth': '9,8 m/s², cukup kuat untuk mempertahankan atmosfer tebal',
    'mars': '3,7 m/s², hanya 38% dari tarikan gravitasi Bumi',
  },
  {
    'category': 'Atmosfer',
    'earth': 'Atmosfer padat dan kaya oksigen mendukung kehidupan beragam',
    'mars': 'Atmosfer tipis, 95% CO₂, tidak dapat bernapas bagi manusia',
  },
  {
    'category': 'Suhu',
    'earth': 'Rata-rata 15°C, iklim ramah untuk kehidupan',
    'mars': 'Rata-rata -63°C, lingkungan dingin ekstrem',
  },
  {
    'category': 'Air',
    'earth': '71% permukaan tertutup oleh lautan air cair',
    'mars': 'Tidak ada air cair di permukaan, es beku di tutup kutub',
  },
  {
    'category': 'Panjang Hari',
    'earth': '24 jam untuk satu rotasi penuh',
    'mars': '24,6 jam (1 Sol), sangat mirip dengan Bumi',
  },
  {
    'category': 'Panjang Tahun',
    'earth': '365,25 hari untuk menyelesaikan satu orbit mengelilingi Matahari',
    'mars': '687 hari Bumi, hampir dua kali lebih panjang dari tahun Bumi',
  },
  {
    'category': 'Kehidupan',
    'earth': 'Keanekaragaman hayati melimpah di semua ekosistem',
    'mars':
        'Tidak ada deteksi kehidupan yang terkonfirmasi, masa lalu atau sekarang',
  },
];
