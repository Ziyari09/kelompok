import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uranus to Neptune',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0D2C),
        colorScheme: const ColorScheme.dark(
          primary: Colors.lightBlue,
          secondary: Colors.lightBlueAccent,
        ),
      ),
      home: const UranusPage(),
    );
  }
}

// ==================== URANUS MAIN PAGE ====================
class UranusPage extends StatefulWidget {
  const UranusPage({super.key});

  @override
  State<UranusPage> createState() => _UranusPageState();
}

class _UranusPageState extends State<UranusPage> with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0E27), Color(0xFF0D1B3A), Color(0xFF0A0E27)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF60A5FA), Color(0xFF22D3EE)],
                  ).createShader(bounds),
                  child: const Text("URANUS", style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, letterSpacing: 4, color: Colors.white)),
                ),
                const SizedBox(height: 8),
                Text("Ice Giant Planet", style: TextStyle(fontSize: 16, color: Colors.blue.shade300.withOpacity(0.7))),
                const SizedBox(height: 40),
                GestureDetector(
                  onTapDown: (_) => setState(() => _scale = 1.1),
                  onTapUp: (_) => setState(() => _scale = 1.0),
                  onTapCancel: () => setState(() => _scale = 1.0),
                  child: AnimatedScale(
                    scale: _scale,
                    duration: const Duration(milliseconds: 200),
                    child: _buildPlanet(),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      InfoCard(title: "Radius", value: "25,362 km", icon: Icons.public, color: Color(0xFF60A5FA)),
                      InfoCard(title: "Gravity", value: "8.7 m/s²", icon: Icons.arrow_downward, color: Color(0xFF34D399)),
                      InfoCard(title: "Temp", value: "-224°C", icon: Icons.thermostat, color: Color(0xFFA78BFA)),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    "Uranus adalah planet ketujuh dari Matahari dan dikenal sebagai planet es raksasa. "
                    "Planet ini berotasi miring hingga 98 derajat, membuatnya tampak berputar sambil tidur.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue.shade100.withOpacity(0.7), fontSize: 15, height: 1.6),
                  ),
                ),
                const SizedBox(height: 40),
                _buildQuickFacts(),
                const SizedBox(height: 40),
                Text("Pelajari fakta menarik tentang Uranus", style: TextStyle(color: Colors.blue.shade300.withOpacity(0.6), fontSize: 14)),
                const SizedBox(height: 16),
                _buildButton(context, "Explore Uranus", false),
                const SizedBox(height: 20),
                // Tombol transisi ke Neptunus
                Text("Atau lanjutkan perjalanan ke planet berikutnya", style: TextStyle(color: Colors.blue.shade300.withOpacity(0.5), fontSize: 13)),
                const SizedBox(height: 12),
                _buildButton(context, "Journey to Neptune", true),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlanet() {
    return SizedBox(
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.4), blurRadius: 80, spreadRadius: 20)],
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Transform.rotate(angle: _controller.value * 2 * math.pi, child: child),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(colors: [Color(0xFF22D3EE), Color(0xFF60A5FA), Color(0xFF2563EB)]),
                    boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.6), blurRadius: 30, spreadRadius: 5)],
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [Colors.white.withOpacity(0.2), Colors.transparent]),
                  ),
                ),
                Transform.rotate(
                  angle: -0.2,
                  child: Container(
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(color: Colors.blue.withOpacity(0.5), width: 4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFacts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue.withOpacity(0.1), Colors.cyan.withOpacity(0.1)]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF60A5FA), Color(0xFF22D3EE)]), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.info_outline, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                const Text('Quick Facts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF93C5FD))),
              ],
            ),
            const SizedBox(height: 16),
            _factRow(Icons.nightlight_round, '27 Moons', 'Natural satellites'),
            const SizedBox(height: 12),
            _factRow(Icons.sync, '84 Years', 'Orbital period'),
            const SizedBox(height: 12),
            _factRow(Icons.air, '900 km/h', 'Wind speed'),
          ],
        ),
      ),
    );
  }

  Widget _factRow(IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF60A5FA), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
              Text(label, style: TextStyle(color: Colors.blue.shade200.withOpacity(0.6), fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String text, bool isNeptune) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isNeptune 
            ? [const Color(0xFF1E40AF), const Color(0xFF4338CA)] // Warna lebih gelap untuk Neptune
            : [const Color(0xFF3B82F6), const Color(0xFF06B6D4)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: (isNeptune ? Colors.indigo : Colors.blue).withOpacity(0.4), blurRadius: 20, spreadRadius: 2)],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            if (isNeptune) {
              Navigator.push(
                context, 
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const NeptunePage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOutCubic;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeIn),
                    );
                    
                    return SlideTransition(
                      position: offsetAnimation,
                      child: FadeTransition(
                        opacity: fadeAnimation,
                        child: child,
                      ),
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 1200),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(isNeptune ? Icons.rocket_launch : Icons.explore, color: Colors.white, size: 22),
                const SizedBox(width: 12),
                Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== INFO CARD ====================
class InfoCard extends StatefulWidget {
  final String title, value;
  final IconData icon;
  final Color color;

  const InfoCard({super.key, required this.title, required this.value, required this.icon, required this.color});

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          width: 105,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B).withOpacity(0.4),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: widget.color.withOpacity(0.3)),
            boxShadow: _isPressed ? [] : [BoxShadow(color: widget.color.withOpacity(0.2), blurRadius: 10)],
          ),
          child: Column(
            children: [
              Icon(widget.icon, color: widget.color, size: 24),
              const SizedBox(height: 8),
              Text(widget.value, style: TextStyle(color: widget.color, fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Text(widget.title, style: TextStyle(color: Colors.blue.shade200.withOpacity(0.6), fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== NEPTUNE PAGE ====================
class NeptunePage extends StatefulWidget {
  const NeptunePage({super.key});

  @override
  State<NeptunePage> createState() => _NeptunePageState();
}

class _NeptunePageState extends State<NeptunePage> with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 25))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0E27), Color(0xFF1E1B4B), Color(0xFF0A0E27)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF4F46E5), Color(0xFF0EA5E9)],
                  ).createShader(bounds),
                  child: const Text("NEPTUNE", style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, letterSpacing: 4, color: Colors.white)),
                ),
                const SizedBox(height: 8),
                Text("The Farthest Ice Giant", style: TextStyle(fontSize: 16, color: Colors.indigo.shade300.withOpacity(0.7))),
                const SizedBox(height: 40),
                GestureDetector(
                  onTapDown: (_) => setState(() => _scale = 1.1),
                  onTapUp: (_) => setState(() => _scale = 1.0),
                  onTapCancel: () => setState(() => _scale = 1.0),
                  child: AnimatedScale(
                    scale: _scale,
                    duration: const Duration(milliseconds: 200),
                    child: _buildNeptune(),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      InfoCard(title: "Radius", value: "24,622 km", icon: Icons.public, color: Color(0xFF4F46E5)),
                      InfoCard(title: "Gravity", value: "11.2 m/s²", icon: Icons.arrow_downward, color: Color(0xFF34D399)),
                      InfoCard(title: "Temp", value: "-214°C", icon: Icons.thermostat, color: Color(0xFF8B5CF6)),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    "Neptunus adalah planet kedelapan dan terjauh dari Matahari dalam tata surya kita. "
                    "Planet ini dikenal dengan warna biru gelapnya dan memiliki angin terkuat di antara semua planet.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.indigo.shade100.withOpacity(0.7), fontSize: 15, height: 1.6),
                  ),
                ),
                const SizedBox(height: 40),
                _buildQuickFacts(),
                const SizedBox(height: 40),
                Text("Jelajahi misteri planet terjauh", style: TextStyle(color: Colors.indigo.shade300.withOpacity(0.6), fontSize: 14)),
                const SizedBox(height: 16),
                _buildBackButton(context),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNeptune() {
    return SizedBox(
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.indigo.withOpacity(0.4), blurRadius: 80, spreadRadius: 20)],
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Transform.rotate(angle: _controller.value * 2 * math.pi, child: child),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6), Color(0xFF1E40AF)]),
                    boxShadow: [BoxShadow(color: Colors.indigo.withOpacity(0.6), blurRadius: 30, spreadRadius: 5)],
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [Colors.white.withOpacity(0.15), Colors.transparent]),
                  ),
                ),
                Positioned(
                  left: 50,
                  top: 80,
                  child: Container(
                    width: 40,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFacts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.indigo.withOpacity(0.1), Colors.blue.withOpacity(0.1)]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.indigo.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF4F46E5), Color(0xFF0EA5E9)]), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.info_outline, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                const Text('Quick Facts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF818CF8))),
              ],
            ),
            const SizedBox(height: 16),
            _factRow(Icons.nightlight_round, '14 Moons', 'Natural satellites'),
            const SizedBox(height: 12),
            _factRow(Icons.sync, '165 Years', 'Orbital period'),
            const SizedBox(height: 12),
            _factRow(Icons.air, '2,100 km/h', 'Wind speed'),
          ],
        ),
      ),
    );
  }

  Widget _factRow(IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF4F46E5), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
              Text(label, style: TextStyle(color: Colors.indigo.shade200.withOpacity(0.6), fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1E40AF), Color(0xFF4338CA)]),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.indigo.withOpacity(0.4), blurRadius: 20, spreadRadius: 2)],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.arrow_back, color: Colors.white, size: 22),
                SizedBox(width: 12),
                Text("Back to Uranus", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}