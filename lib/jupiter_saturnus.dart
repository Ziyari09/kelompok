import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const PlanetExplorerApp());
}

class PlanetExplorerApp extends StatelessWidget {
  const PlanetExplorerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planet Explorer',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0A1628),
        fontFamily: 'Arial',
      ),
      home: const PlanetExplorerHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PlanetData {
  final String name;
  final String description;
  final String image;
  final Color primaryColor;
  final Color secondaryColor;
  final List<SatelliteData> satellites;
  final Map<String, String> facts;

  PlanetData({
    required this.name,
    required this.description,
    required this.image,
    required this.primaryColor,
    required this.secondaryColor,
    required this.satellites,
    required this.facts,
  });
}

class SatelliteData {
  final String name;
  final String description;
  final String image;
  final Map<String, String> specs;

  SatelliteData({
    required this.name,
    required this.description,
    required this.image,
    required this.specs,
  });
}

class PlanetExplorerHome extends StatefulWidget {
  const PlanetExplorerHome({Key? key}) : super(key: key);

  @override
  State<PlanetExplorerHome> createState() => _PlanetExplorerHomeState();
}

class _PlanetExplorerHomeState extends State<PlanetExplorerHome>
    with TickerProviderStateMixin {
  int selectedPlanetIndex = 0;
  int selectedSatelliteIndex = 0;
  late AnimationController _glowAnimController;
  late AnimationController _floatAnimController;

  @override
  void initState() {
    super.initState();
    _glowAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _floatAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowAnimController.dispose();
    _floatAnimController.dispose();
    super.dispose();
  }

  final List<PlanetData> planets = [
    PlanetData(
      name: 'Jupiter',
      description:
          'Jupiter adalah planet terbesar di Tata Surya kita, dengan diameter sekitar 143.000 kilometer. Planet gas raksasa ini memiliki massa 2,5 kali lebih besar dari gabungan semua planet lainnya.\n\n'
          'Atmosfer Jupiter terdiri dari hidrogen (90%) dan helium (10%), dengan jejak metana, air, dan amonia. Fitur paling ikonik adalah Bintik Merah Besar, badai antikejadian raksasa yang telah berlangsung setidaknya 400 tahun.\n\n'
          'Jupiter memiliki medan magnet terkuat di Tata Surya - 20.000 kali lebih kuat dari Bumi. Planet ini memiliki 95+ bulan, termasuk empat bulan Galilean yang ditemukan Galileo Galilei pada 1610.',
      image: '🟠',
      primaryColor: Color(0xFFD4A574),
      secondaryColor: Color(0xFFF5D7A0),
      facts: {
        'Jarak dari Matahari': '778 juta km',
        'Periode Orbit': '11,9 tahun',
        'Periode Rotasi': '9,9 jam',
        'Diameter': '142.984 km',
        'Massa': '1,898 × 10²⁷ kg',
        'Jumlah Bulan': '95+',
      },
      satellites: [
        SatelliteData(
          name: 'Io',
          description:
              'Io adalah objek paling aktif secara vulkanik di Tata Surya dengan lebih dari 400 gunung berapi aktif. Aktivitas vulkanik ekstrem ini disebabkan oleh pemanasan tidal dari Jupiter.\n\n'
              'Permukaan Io dipenuhi belerang dan sulfur dioksida, memberikan warna kuning-oranye yang khas. Suhu lava dapat mencapai 1.600°C, lebih panas dari vulkan di Bumi.',
          image: '🌕',
          specs: {
            'Jarak dari Jupiter': '421.700 km',
            'Diameter': '3.643 km',
            'Periode Orbit': '1,77 hari',
          },
        ),
        SatelliteData(
          name: 'Europa',
          description:
              'Europa adalah kandidat utama dalam pencarian kehidupan ekstraterestrial. Di bawah lapisan es setebal 15-25 km, terdapat samudra air asin global dengan volume dua kali lipat dari semua samudra Bumi.\n\n'
              'Teleskop Hubble mendeteksi plume uap air yang menyembur hingga 200 km, memberikan peluang untuk mempelajari samudra tanpa mengebor es. Misi NASA Europa Clipper akan segera diluncurkan untuk penelitian lebih lanjut.',
          image: '🌖',
          specs: {
            'Jarak dari Jupiter': '671.100 km',
            'Diameter': '3.122 km',
            'Periode Orbit': '3,55 hari',
          },
        ),
        SatelliteData(
          name: 'Ganymede',
          description:
              'Ganymede adalah bulan terbesar di Tata Surya, bahkan lebih besar dari Merkurius. Ini adalah satu-satunya bulan dengan magnetosfer sendiri, yang menciptakan aurora di kutubnya.\n\n'
              'Permukaan terbagi menjadi medan gelap tua penuh kawah (4 miliar tahun) dan medan terang bergaris (1-2 miliar tahun). Ganymede memiliki samudra bawah permukaan yang mungkin mengandung lebih banyak air dari semua samudra Bumi.',
          image: '🌗',
          specs: {
            'Jarak dari Jupiter': '1.070.400 km',
            'Diameter': '5.268 km',
            'Periode Orbit': '7,15 hari',
          },
        ),
        SatelliteData(
          name: 'Callisto',
          description:
              'Callisto memiliki permukaan paling banyak berkawah di Tata Surya, hampir tidak berubah sejak 4,5 miliar tahun lalu. Fitur utamanya adalah Valhalla, sistem cincin dengan diameter 3.800 km.\n\n'
              'Meskipun tampak mati, Callisto mungkin memiliki samudra air asin 150-200 km di bawah permukaan. Radiasi rendah menjadikannya kandidat ideal untuk basis eksplorasi berawak masa depan.',
          image: '🌘',
          specs: {
            'Jarak dari Jupiter': '1.882.700 km',
            'Diameter': '4.821 km',
            'Periode Orbit': '16,69 hari',
          },
        ),
      ],
    ),
    PlanetData(
      name: 'Saturnus',
      description:
          'Saturnus adalah planet keenam dari Matahari dan terbesar kedua di Tata Surya. Planet ini terkenal dengan sistem cincinnya yang spektakuler, terdiri dari miliaran partikel es dan batu.\n\n'
          'Saturnus adalah planet gas raksasa yang sebagian besar terdiri dari hidrogen (96%) dan helium (3%). Angin di Saturnus dapat mencapai 1.800 km/jam. Fitur unik adalah badai heksagonal di kutub utara dengan diameter 30.000 km.\n\n'
          'Planet ini memiliki 146+ bulan dan densitas terendah di Tata Surya - bahkan lebih rendah dari air. Misi Cassini (2004-2017) mengungkap banyak misteri tentang Saturnus dan bulan-bulannya.',
      image: '🪐',
      primaryColor: Color(0xFFF4E4C1),
      secondaryColor: Color(0xFFFFE8B8),
      facts: {
        'Jarak dari Matahari': '1,43 miliar km',
        'Periode Orbit': '29,5 tahun',
        'Periode Rotasi': '10,7 jam',
        'Diameter': '120.536 km',
        'Massa': '5,683 × 10²⁶ kg',
        'Jumlah Bulan': '146+',
      },
      satellites: [
        SatelliteData(
          name: 'Titan',
          description:
              'Titan adalah satu-satunya bulan dengan atmosfer tebal yang substansial, terdiri dari nitrogen (98,4%) dan metana (1,6%). Atmosfernya 50% lebih tebal dari Bumi.\n\n'
              'Titan memiliki siklus metana yang mirip siklus air di Bumi - hujan metana, sungai, danau, dan laut. Ligeia Mare, salah satu lautnya, seluas 130.000 km². Titan adalah kandidat terbaik untuk kehidupan berbasis metana yang eksotis.',
          image: '🌕',
          specs: {
            'Jarak dari Saturnus': '1.221.870 km',
            'Diameter': '5.150 km',
            'Periode Orbit': '15,95 hari',
          },
        ),
        SatelliteData(
          name: 'Enceladus',
          description:
              'Enceladus adalah bulan kecil dengan permukaan es putih bersih yang memantulkan hampir 100% cahaya. Jet uap air menyembur dari "tiger stripes" di kutub selatan hingga ratusan kilometer.\n\n'
              'Di bawah es terdapat samudra air cair global. Cassini mendeteksi air, garam, silika, molekik organik, dan hidrogen - indikasi ventilasi hidrotermal yang bisa mendukung kehidupan mikroba.',
          image: '🌖',
          specs: {
            'Jarak dari Saturnus': '237.948 km',
            'Diameter': '504 km',
            'Periode Orbit': '1,37 hari',
          },
        ),
        SatelliteData(
          name: 'Mimas',
          description:
              'Mimas terkenal dengan kawah Herschel yang raksasa (diameter 130 km), membuat bulan ini mirip Death Star dari Star Wars. Kawah ini hampir menghancurkan Mimas sepenuhnya.\n\n'
              'Meskipun permukaan penuh kawah tua, penelitian terbaru menunjukkan Mimas mungkin memiliki samudra internal tersembunyi. Mimas juga menciptakan Cassini Division di cincin Saturnus melalui resonansi orbital.',
          image: '🌗',
          specs: {
            'Jarak dari Saturnus': '185.539 km',
            'Diameter': '396 km',
            'Periode Orbit': '0,94 hari',
          },
        ),
        SatelliteData(
          name: 'Rhea',
          description:
              'Rhea adalah bulan terbesar kedua Saturnus dengan permukaan sangat tua dan penuh kawah. Bulan ini menunjukkan dikotomi permukaan antara hemisfer depan dan belakang.\n\n'
              'Rhea mungkin pernah memiliki sistem cincin sendiri yang tipis, menjadikannya satu-satunya bulan dengan cincin. Komposisinya terutama es air dengan jejak oksigen dan karbon dioksida di atmosfer tipisnya.',
          image: '🌘',
          specs: {
            'Jarak dari Saturnus': '527.108 km',
            'Diameter': '1.527 km',
            'Periode Orbit': '4,52 hari',
          },
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 1.5,
            colors: [Color(0xFF1a2850), Color(0xFF0A1628), Color(0xFF000814)],
          ),
        ),
        child: Stack(
          children: [
            // Animated background stars
            ...List.generate(100, (index) {
              return AnimatedBuilder(
                animation: _floatAnimController,
                builder: (context, child) {
                  return Positioned(
                    left: (index * 137) % size.width,
                    top:
                        ((index * 89) % size.height) +
                        (math.sin(
                              _floatAnimController.value * 2 * math.pi + index,
                            ) *
                            3),
                    child: Container(
                      width: (index % 3) + 1.0,
                      height: (index % 3) + 1.0,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                          0.4 + (index % 4) * 0.15,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
            // Main content
            SafeArea(
              child: Column(
                children: [
                  _buildTopBar(),
                  Expanded(
                    child: isDesktop
                        ? _buildDesktopLayout()
                        : _buildMobileLayout(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          const SizedBox(width: 16),
          // Title
          Text(
            'Eksplorasi Planet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left sidebar - Planet navigation
        Container(
          width: 300,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: _buildPlanetNavigation(),
        ),
        // Main content area
        Expanded(child: _buildMainContent()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Top navigation
        Container(height: 140, child: _buildPlanetNavigationHorizontal()),
        // Main content
        Expanded(child: _buildMainContent()),
      ],
    );
  }

  Widget _buildPlanetNavigation() {
    return ListView.builder(
      itemCount: planets.length,
      itemBuilder: (context, index) {
        final planet = planets[index];
        final isSelected = selectedPlanetIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedPlanetIndex = index;
              selectedSatelliteIndex = 0;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
                // Planet circle
                Center(
                  child: AnimatedBuilder(
                    animation: _glowAnimController,
                    builder: (context, child) {
                      return Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: isSelected
                              ? RadialGradient(
                                  colors: [
                                    planet.primaryColor.withOpacity(0.3),
                                    planet.primaryColor.withOpacity(0.1),
                                    Colors.transparent,
                                  ],
                                )
                              : null,
                          border: Border.all(
                            color: isSelected
                                ? planet.primaryColor
                                : Colors.white.withOpacity(0.3),
                            width: isSelected ? 3 : 2,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: planet.primaryColor.withOpacity(
                                      0.3 + _glowAnimController.value * 0.3,
                                    ),
                                    blurRadius:
                                        20 + _glowAnimController.value * 10,
                                    spreadRadius:
                                        5 + _glowAnimController.value * 5,
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            planet.image,
                            style: TextStyle(fontSize: 60),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Planet name
                Text(
                  planet.name,
                  style: TextStyle(
                    color: isSelected ? planet.primaryColor : Colors.white70,
                    fontSize: 20,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlanetNavigationHorizontal() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: planets.length,
      itemBuilder: (context, index) {
        final planet = planets[index];
        final isSelected = selectedPlanetIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedPlanetIndex = index;
              selectedSatelliteIndex = 0;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _glowAnimController,
                  builder: (context, child) {
                    return Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: isSelected
                            ? RadialGradient(
                                colors: [
                                  planet.primaryColor.withOpacity(0.3),
                                  planet.primaryColor.withOpacity(0.1),
                                  Colors.transparent,
                                ],
                              )
                            : null,
                        border: Border.all(
                          color: isSelected
                              ? planet.primaryColor
                              : Colors.white.withOpacity(0.3),
                          width: isSelected ? 3 : 2,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: planet.primaryColor.withOpacity(
                                    0.3 + _glowAnimController.value * 0.3,
                                  ),
                                  blurRadius:
                                      15 + _glowAnimController.value * 8,
                                  spreadRadius:
                                      3 + _glowAnimController.value * 3,
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          planet.image,
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  planet.name,
                  style: TextStyle(
                    color: isSelected ? planet.primaryColor : Colors.white70,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainContent() {
    final planet = planets[selectedPlanetIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Planet info card
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  planet.primaryColor.withOpacity(0.25),
                  planet.secondaryColor.withOpacity(0.15),
                  planet.primaryColor.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: planet.primaryColor.withOpacity(0.4),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: planet.primaryColor.withOpacity(0.2),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: planet.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            planet.image,
                            style: TextStyle(fontSize: 48),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                planet.name,
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: planet.primaryColor,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              Text(
                                'Planet Gas Raksasa',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white60,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: planet.primaryColor.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        planet.description,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.8,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Facts grid
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: planet.facts.entries.map((entry) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: planet.primaryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: planet.primaryColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                entry.key,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: planet.primaryColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                entry.value,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Satellites section header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 28,
                  decoration: BoxDecoration(
                    color: planet.primaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Satelit ${planet.name}',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: planet.primaryColor,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Satellite selection
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: planet.satellites.length,
              itemBuilder: (context, index) {
                final satellite = planet.satellites[index];
                final isSelected = selectedSatelliteIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSatelliteIndex = index;
                    });
                  },
                  child: AnimatedBuilder(
                    animation: _glowAnimController,
                    builder: (context, child) {
                      return Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Container(
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: isSelected
                                    ? RadialGradient(
                                        colors: [
                                          planet.primaryColor.withOpacity(0.3),
                                          planet.primaryColor.withOpacity(0.1),
                                          Colors.transparent,
                                        ],
                                      )
                                    : null,
                                border: Border.all(
                                  color: isSelected
                                      ? planet.primaryColor
                                      : Colors.white.withOpacity(0.3),
                                  width: isSelected ? 3 : 2,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: planet.primaryColor
                                              .withOpacity(
                                                0.4 +
                                                    _glowAnimController.value *
                                                        0.2,
                                              ),
                                          blurRadius:
                                              15 +
                                              _glowAnimController.value * 8,
                                          spreadRadius:
                                              2 + _glowAnimController.value * 2,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Center(
                                child: Text(
                                  satellite.image,
                                  style: TextStyle(fontSize: 38),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              satellite.name,
                              style: TextStyle(
                                color: isSelected
                                    ? planet.primaryColor
                                    : Colors.white70,
                                fontSize: 13,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 28),
          // Selected satellite info
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: planet.primaryColor.withOpacity(0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: planet.primaryColor.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: planet.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            planet.satellites[selectedSatelliteIndex].image,
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                planet.satellites[selectedSatelliteIndex].name,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: planet.primaryColor,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Text(
                                'Satelit Alami',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white60,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: planet.primaryColor.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        planet.satellites[selectedSatelliteIndex].description,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.7,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Specs
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: planet
                          .satellites[selectedSatelliteIndex]
                          .specs
                          .entries
                          .map((entry) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: planet.primaryColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: planet.primaryColor.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.key,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: planet.primaryColor.withOpacity(
                                        0.8,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    entry.value,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
