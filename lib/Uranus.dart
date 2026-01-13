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
        title: 'Uranus Explorer',
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
                  _buildButton(context),
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

    Widget _buildButton(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)]),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.4), blurRadius: 20, spreadRadius: 2)],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UranusDetailPage())),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.explore, color: Colors.white, size: 22),
                  SizedBox(width: 12),
                  Text("Explore Uranus", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
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

  // ==================== DETAIL PAGE ====================
  class UranusDetailPage extends StatefulWidget {
    const UranusDetailPage({super.key});

    @override
    State<UranusDetailPage> createState() => _UranusDetailPageState();
  }

  class _UranusDetailPageState extends State<UranusDetailPage> with SingleTickerProviderStateMixin {
    late AnimationController _controller;
    String _activeTab = 'overview';

    final Map<String, String> _content = {
      'overview': 'Uranus adalah planet ketujuh dari Matahari, sebuah raksasa es yang dingin dan berangin. Planet ini terkenal karena kemiringan sumbu rotasinya yang ekstrem hingga hampir 98 derajat, sehingga terlihat seperti berguling di orbitnya. Uranus memiliki cincin samar, lebih dari dua lusin bulan, dan dinamai dari dewa langit mitologi Yunani.',
      'atmosphere': 'Atmosfer Uranus terdiri dari hidrogen, helium, dan metana. Gas metana menyerap cahaya merah, memberikan warna biru pucat yang khas. Kecepatan angin dapat mencapai 900 km/jam di bagian ekuator. Suhu atmosfer sangat dingin, mencapai -224°C, menjadikannya salah satu planet terdingin di tata surya.',
      'structure': 'Uranus tersusun dari air, metana, dan amonia dalam bentuk es di atas inti batuan kecil. Struktur internalnya terdiri dari tiga lapisan: inti berbatu kecil di tengah, mantel es yang tebal, dan atmosfer gas. Massa Uranus sekitar 14.5 kali massa Bumi, namun kepadatannya relatif rendah.',
    };

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
            gradient: LinearGradient(colors: [Color(0xFF0A0E27), Color(0xFF0D1B3A), Color(0xFF0A0E27)]),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildPlanet(),
                        const SizedBox(height: 20),
                        _buildTitle(),
                        const SizedBox(height: 30),
                        _buildFacts(),
                        const SizedBox(height: 30),
                        _buildTabs(),
                        const SizedBox(height: 20),
                        _buildContent(),
                        const SizedBox(height: 20),
                        _buildFunFact(),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildHeader() {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0E27).withOpacity(0.8),
          border: Border(bottom: BorderSide(color: Colors.blue.withOpacity(0.2))),
        ),
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
            const SizedBox(width: 8),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(colors: [Color(0xFF60A5FA), Color(0xFF22D3EE)]).createShader(bounds),
              child: const Text('Detail Uranus', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      );
    }

    Widget _buildPlanet() {
      return SizedBox(
        height: 280,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(width: 250, height: 250, decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 80, spreadRadius: 20)])),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Transform.rotate(angle: _controller.value * 2 * math.pi, child: child),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: 220, height: 220, decoration: BoxDecoration(shape: BoxShape.circle, gradient: const LinearGradient(colors: [Color(0xFF22D3EE), Color(0xFF60A5FA), Color(0xFF2563EB)]), boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 30, spreadRadius: 5)])),
                  Container(width: 200, height: 200, decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [Colors.white.withOpacity(0.2), Colors.transparent]))),
                  Transform.rotate(angle: -0.2, child: Container(width: 300, height: 80, decoration: BoxDecoration(borderRadius: BorderRadius.circular(150), border: Border.all(color: Colors.blue.withOpacity(0.4), width: 4)))),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildTitle() {
      return Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(colors: [Color(0xFF93C5FD), Color(0xFF67E8F9), Color(0xFF60A5FA)]).createShader(bounds),
            child: const Text('URANUS', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2)),
          ),
          const SizedBox(height: 8),
          Text('The Tilted Ice Giant', style: TextStyle(fontSize: 16, color: Colors.blue.shade300.withOpacity(0.7))),
        ],
      );
    }

    Widget _buildFacts() {
      final facts = [
        {'icon': Icons.public, 'label': 'Radius', 'value': '25,362 km', 'color': const Color(0xFF60A5FA)},
        {'icon': Icons.thermostat, 'label': 'Temperature', 'value': '-224°C', 'color': const Color(0xFF34D399)},
        {'icon': Icons.air, 'label': 'Wind Speed', 'value': '900 km/h', 'color': const Color(0xFFA78BFA)},
        {'icon': Icons.nightlight_round, 'label': 'Moons', 'value': '27', 'color': const Color(0xFFF472B6)},
        {'icon': Icons.sync, 'label': 'Orbit Period', 'value': '84 years', 'color': const Color(0xFFFBBF24)},
        {'icon': Icons.arrow_downward, 'label': 'Gravity', 'value': '8.7 m/s²', 'color': const Color(0xFFFB923C)},
      ];

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemCount: facts.length,
          itemBuilder: (context, i) {
            final f = facts[i];
            return _FactCard(icon: f['icon'] as IconData, label: f['label'] as String, value: f['value'] as String, color: f['color'] as Color);
          },
        ),
      );
    }

    Widget _buildTabs() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: const Color(0xFF1E293B).withOpacity(0.4), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.withOpacity(0.2))),
          child: Row(children: [_tab('overview', 'Overview'), _tab('atmosphere', 'Atmosphere'), _tab('structure', 'Structure')]),
        ),
      );
    }

    Widget _tab(String id, String label) {
      final isActive = _activeTab == id;
      return Expanded(
        child: GestureDetector(
          onTap: () => setState(() => _activeTab = id),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              gradient: isActive ? const LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)]) : null,
              borderRadius: BorderRadius.circular(8),
              boxShadow: isActive ? [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 12, spreadRadius: 2)] : [],
            ),
            child: Text(label, textAlign: TextAlign.center, style: TextStyle(color: isActive ? Colors.white : Colors.blue.shade300.withOpacity(0.6), fontWeight: isActive ? FontWeight.w600 : FontWeight.normal, fontSize: 14)),
          ),
        ),
      );
    }

    Widget _buildContent() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFF1E293B).withOpacity(0.4), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.blue.withOpacity(0.2))),
          child: Text(_content[_activeTab]!, textAlign: TextAlign.justify, style: TextStyle(color: Colors.blue.shade100.withOpacity(0.8), fontSize: 16, height: 1.6)),
        ),
      );
    }

    Widget _buildFunFact() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue.withOpacity(0.1), Colors.cyan.withOpacity(0.1)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.blue.withOpacity(0.3))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 48, height: 48, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF60A5FA), Color(0xFF22D3EE)]), borderRadius: BorderRadius.circular(24)), child: const Icon(Icons.auto_awesome, color: Colors.white, size: 24)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Did You Know?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF93C5FD))),
                    const SizedBox(height: 8),
                    Text('Uranus berotasi hampir miring 98 derajat, sehingga kutubnya menghadap Matahari selama separuh orbitnya. Hal ini membuat musim di Uranus sangat ekstrem—setiap kutub mengalami 42 tahun siang hari diikuti 42 tahun malam hari!', style: TextStyle(color: Colors.blue.shade100.withOpacity(0.7), fontSize: 15, height: 1.5)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  class _FactCard extends StatelessWidget {
    final IconData icon;
    final String label, value;
    final Color color;

    const _FactCard({required this.icon, required this.label, required this.value, required this.color});

    @override
    Widget build(BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFF1E293B).withOpacity(0.4), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.3))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 12, color: Colors.blue.shade200.withOpacity(0.6))),
          ],
        ),
      );
    }
  }