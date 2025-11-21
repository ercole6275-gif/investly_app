import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const InvestlyApp());
}

class InvestlyApp extends StatelessWidget {
  const InvestlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF00FF6A);
    return MaterialApp(
      title: 'Investly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050608),
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF050608),
          elevation: 0,
          centerTitle: true,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

/// SPLASH

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.forward();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        _fadeRoute(const OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Route _fadeRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (_, a, __) => FadeTransition(opacity: a, child: page),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF00FF6A);
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _scale,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/logo_investly.PNG',
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Investly',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '📈 Investire, ma semplice.',
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ONBOARDING

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  final List<_OnbPageData> _pages = const [
    _OnbPageData(
      emoji: '🧭',
      title: 'Benvenuto in Investly',
      text: 'Investire non deve essere complicato.\nTi aiutiamo a dare un senso ai tuoi soldi.',
    ),
    _OnbPageData(
      emoji: '📊',
      title: 'Portafogli semplici',
      text: 'Profili chiari, numeri comprensibili,\n niente grafici da astronauta.',
    ),
    _OnbPageData(
      emoji: '🚀',
      title: 'PAC e obiettivi',
      text: 'Imposta un obiettivo, un PAC mensile,\n e guarda come cresce nel tempo.',
    ),
  ];

  void _next() {
    if (_index < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      Navigator.of(context).pushReplacement(
        _slideRoute(const ProfileSetupScreen()),
      );
    }
  }

  Route _slideRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, a, __) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(a),
        child: page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF00FF6A);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Image.asset(
              'assets/logo_investly.PNG',
              width: 48,
              height: 48,
            ),
            const SizedBox(height: 8),
            const Text(
              'Investly',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) => _OnboardingPage(data: _pages[i]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                  height: 6,
                  width: _index == i ? 18 : 8,
                  decoration: BoxDecoration(
                    color: _index == i ? primary : Colors.white24,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: Text(_index == _pages.length - 1
                      ? 'Inizia ora'
                      : 'Avanti'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnbPageData {
  final String emoji;
  final String title;
  final String text;
  const _OnbPageData(
      {required this.emoji, required this.title, required this.text});
}

class _OnboardingPage extends StatelessWidget {
  final _OnbPageData data;
  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.emoji,
            style: const TextStyle(fontSize: 52),
          ),
          const SizedBox(height: 24),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            data.text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

/// PROFILO FINANZIARIO

class ProfileData {
  final String goal;
  final String horizon;
  final String risk;
  final double monthly;

  const ProfileData({
    required this.goal,
    required this.horizon,
    required this.risk,
    required this.monthly,
  });
}

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  String _goal = 'Costruire un capitale';
  String _horizon = '3-5 anni';
  String _risk = 'Moderato';
  double _monthly = 100;

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF00FF6A);
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎯 Il tuo profilo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Cosa vuoi ottenere con Investly?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Costruire un capitale',
              'Investire il risparmio mensile',
              'Raggiungere un obiettivo preciso',
            ].map((g) {
              final selected = _goal == g;
              return ChoiceChip(
                label: Text(g),
                selected: selected,
                onSelected: (_) => setState(() => _goal = g),
                selectedColor: primary.withOpacity(0.2),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Quanto tempo hai in mente?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              '1-3 anni',
              '3-5 anni',
              '5-10 anni',
              '10+ anni',
            ].map((h) {
              final selected = _horizon == h;
              return ChoiceChip(
                label: Text(h),
                selected: selected,
                onSelected: (_) => setState(() => _horizon = h),
                selectedColor: primary.withOpacity(0.2),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Come ti senti rispetto al rischio?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Basso',
              'Moderato',
              'Alto',
            ].map((r) {
              final selected = _risk == r;
              return ChoiceChip(
                label: Text(r),
                selected: selected,
                onSelected: (_) => setState(() => _risk = r),
                selectedColor: primary.withOpacity(0.2),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '💶 Quanto puoi investire al mese?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                '${_monthly.toInt()}€',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ],
          ),
          Slider(
            min: 25,
            max: 1000,
            divisions: 39,
            value: _monthly,
            label: '${_monthly.toInt()}€',
            onChanged: (v) => setState(() => _monthly = v),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              onPressed: () {
                final profile = ProfileData(
                  goal: _goal,
                  horizon: _horizon,
                  risk: _risk,
                  monthly: _monthly,
                );
                Navigator.of(context).pushReplacement(
                  _fadeRoute(DashboardShell(profile: profile)),
                );
              },
              child: const Text('Crea il mio profilo'),
            ),
          ),
        ],
      ),
    );
  }

  Route _fadeRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, a, __) => FadeTransition(opacity: a, child: page),
    );
  }
}

/// DASHBOARD + NAV BOTTOM

class DashboardShell extends StatefulWidget {
  final ProfileData profile;
  const DashboardShell({super.key, required this.profile});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeDashboard(profile: widget.profile),
      PortfoliosPage(profile: widget.profile),
      PacSimulatorPage(profile: widget.profile),
      GoalsPage(profile: widget.profile),
      BrokersPage(profile: widget.profile),
    ];

    final titles = [
      '📊 Dashboard',
      '💼 Portafogli',
      '🔁 PAC',
      '🎯 Obiettivi',
      '🏦 Broker',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_index]),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: pages[_index],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: 'Portafogli'),
          NavigationDestination(
              icon: Icon(Icons.autorenew_outlined), label: 'PAC'),
          NavigationDestination(
              icon: Icon(Icons.flag_outlined), label: 'Obiettivi'),
          NavigationDestination(
              icon: Icon(Icons.account_balance_outlined), label: 'Broker'),
        ],
      ),
    );
  }
}

/// HOME DASHBOARD

class HomeDashboard extends StatelessWidget {
  final ProfileData profile;
  const HomeDashboard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final total = 7540.0;
    final perf = 0.072;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Valore portafoglio (simulato)',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: total),
                duration: const Duration(milliseconds: 800),
                builder: (_, value, __) => Text(
                  '€ ${value.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '+${(perf * 100).toStringAsFixed(1)}% ultimo anno',
                style: const TextStyle(color: Color(0xFF00FF6A)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Il tuo profilo',
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 8),
              Text('🎯 Obiettivo: ${profile.goal}'),
              Text('🕒 Orizzonte: ${profile.horizon}'),
              Text('😌 Rischio: ${profile.risk}'),
              Text('💶 PAC mensile: ${profile.monthly.toInt()}€'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Suggerimenti di oggi',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const _Bullet('Non è un consiglio finanziario, ma una simulazione.'),
        const _Bullet('Controlla il tuo PAC almeno 1 volta al mese.'),
        const _Bullet('Evita di “fissare” il portafoglio ogni ora.'),
      ],
    );
  }
}

/// PORTAFOGLI

class PortfoliosPage extends StatelessWidget {
  final ProfileData profile;
  const PortfoliosPage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final portfolios = [
      {
        'emoji': '🛡️',
        'name': 'Conservativo',
        'desc': 'Più obbligazioni, meno volatilità.',
        'risk': 'Basso',
        'ret': '4.0%',
      },
      {
        'emoji': '⚖️',
        'name': 'Bilanciato',
        'desc': 'Mix tra azioni e obbligazioni.',
        'risk': 'Medio',
        'ret': '6.0%',
      },
      {
        'emoji': '🚀',
        'name': 'Crescita',
        'desc': 'Più azioni, crescita potenziale.',
        'risk': 'Alto',
        'ret': '8.0%',
      },
    ];

    String recommended;
    if (profile.risk == 'Basso') {
      recommended = 'Conservativo';
    } else if (profile.risk == 'Moderato') {
      recommended = 'Bilanciato';
    } else {
      recommended = 'Crescita';
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: portfolios.length,
      itemBuilder: (_, i) {
        final p = portfolios[i];
        final isRecommended = p['name'] == recommended;
        return _Card(
          margin: const EdgeInsets.only(bottom: 12),
          border: isRecommended
              ? Border.all(color: const Color(0xFF00FF6A))
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${p['emoji']}  ${p['name']}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(p['desc'] as String,
                  style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              Text('Rischio: ${p['risk']}'),
              Text('Rendimento atteso: ${p['ret']} / anno'),
              const SizedBox(height: 8),
              if (isRecommended)
                const Text(
                  'Consigliato per il tuo profilo ⭐',
                  style: TextStyle(color: Color(0xFF00FF6A)),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// PAC SIMULATOR

class PacSimulatorPage extends StatefulWidget {
  final ProfileData profile;
  const PacSimulatorPage({super.key, required this.profile});

  @override
  State<PacSimulatorPage> createState() => _PacSimulatorPageState();
}

class _PacSimulatorPageState extends State<PacSimulatorPage> {
  int _years = 5;
  double _monthlyOverride = 0;

  double get _monthly =>
      _monthlyOverride > 0 ? _monthlyOverride : widget.profile.monthly;

  double _rateForRisk(String risk) {
    switch (risk) {
      case 'Basso':
        return 0.03;
      case 'Moderato':
        return 0.05;
      case 'Alto':
        return 0.08;
      default:
        return 0.05;
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = _rateForRisk(widget.profile.risk);
    final n = _years * 12;
    final m = _monthly;
    // Valore futuro di una rendita (PAC)
    final fv = (r == 0)
        ? m * n
        : m * (pow(1 + r / 12, n) - 1) / (r / 12);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🔁 Simulatore PAC',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text('Rischio: ${widget.profile.risk}'),
              Text(
                  'Rendimento annuo stimato: ${(r * 100).toStringAsFixed(1)}%'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Quanto vuoi investire ogni mese?',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${_monthly.toInt()}€ / mese'),
            TextButton(
              onPressed: () => setState(() => _monthlyOverride = 0),
              child: const Text('Usa il valore del profilo'),
            ),
          ],
        ),
        Slider(
          min: 25,
          max: 1000,
          divisions: 39,
          value: _monthly,
          label: '${_monthly.toInt()}€',
          onChanged: (v) => setState(() => _monthlyOverride = v),
        ),
        const SizedBox(height: 16),
        const Text(
          'Per quanti anni?',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Slider(
          min: 1,
          max: 30,
          divisions: 29,
          value: _years.toDouble(),
          label: '$_years anni',
          onChanged: (v) => setState(() => _years = v.round()),
        ),
        const SizedBox(height: 24),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Risultato stimato',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: fv),
                duration: const Duration(milliseconds: 600),
                builder: (_, value, __) => Text(
                  '€ ${value.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                  'Versamenti totali: € ${(m * n).toStringAsFixed(0)} (senza rendimento)'),
              Text(
                  'Rendimento simulato: ~€ ${(fv - m * n).toStringAsFixed(0)}'),
              const SizedBox(height: 8),
              const Text(
                'Non è un consiglio finanziario. È solo una simulazione a scopo educativo.',
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// GOALS

class GoalsPage extends StatelessWidget {
  final ProfileData profile;
  const GoalsPage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final goals = [
      {
        'emoji': '✈️',
        'name': 'Viaggio',
        'target': 3000,
        'current': 1200,
        'date': 'Estate 2026',
      },
      {
        'emoji': '🚗',
        'name': 'Auto',
        'target': 10000,
        'current': 2500,
        'date': 'Fine 2027',
      },
      {
        'emoji': '🛟',
        'name': 'Fondo emergenze',
        'target': 2000,
        'current': 750,
        'date': 'Sempre',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: goals.length,
      itemBuilder: (_, i) {
        final g = goals[i];
        final progress = (g['current'] as num) / (g['target'] as num);
        return _Card(
          margin: const EdgeInsets.only(bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${g['emoji']}  ${g['name']}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                g['date'] as String,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress.toDouble().clamp(0, 1),
                color: const Color(0xFF00FF6A),
                backgroundColor: Colors.white10,
              ),
              const SizedBox(height: 8),
              Text(
                '€ ${g['current']} / € ${g['target']}',
                style:
                    const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// BROKERS

class BrokersPage extends StatelessWidget {
  final ProfileData profile;
  const BrokersPage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final brokers = [
      {
        'name': 'Trade Republic',
        'emoji': '📱',
        'desc': 'Ideale per PAC, ETF, utilizzo da smartphone.',
        'area': 'EU / Italia',
        'ease': 'Facile',
      },
      {
        'name': 'Scalable Capital',
        'emoji': '📊',
        'desc': 'Ottimo per piani di accumulo automatizzati.',
        'area': 'EU / Italia',
        'ease': 'Facile',
      },
      {
        'name': 'DEGIRO',
        'emoji': '🌍',
        'desc': 'Più mercati e strumenti per chi vuole controllo.',
        'area': 'EU',
        'ease': 'Intermedio',
      },
      {
        'name': 'eToro',
        'emoji': '👥',
        'desc': 'Social trading, copy portfolio, community.',
        'area': 'Globale',
        'ease': 'Facile',
      },
    ];

    String suggested;
    if (profile.risk == 'Basso') {
      suggested = 'Scalable Capital';
    } else if (profile.risk == 'Moderato') {
      suggested = 'Trade Republic';
    } else {
      suggested = 'DEGIRO';
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: brokers.length,
      itemBuilder: (_, i) {
        final b = brokers[i];
        final isSuggested = b['name'] == suggested;
        return _Card(
          margin: const EdgeInsets.only(bottom: 14),
          border: isSuggested
              ? Border.all(color: const Color(0xFF00FF6A))
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${b['emoji']}  ${b['name']}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                b['desc'] as String,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 6),
              Text('Area: ${b['area']}'),
              Text('Difficoltà: ${b['ease']}'),
              if (isSuggested) ...[
                const SizedBox(height: 6),
                const Text(
                  'Suggerito per il tuo profilo ⭐',
                  style: TextStyle(color: Color(0xFF00FF6A)),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

/// WIDGET DI BASE

class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;

  const _Card({required this.child, this.margin, this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111217),
        borderRadius: BorderRadius.circular(16),
        border: border,
      ),
      child: child,
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('• ', style: TextStyle(color: Colors.white70)),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
      ],
    );
  }
}
