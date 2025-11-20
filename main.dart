
import 'package:flutter/material.dart';

void main() {
  runApp(const InvestlyApp());
}

class InvestlyApp extends StatelessWidget {
  const InvestlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFF0B0C0F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00D26A),
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B0C0F),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const OnboardingScreen(),
    );
  }
}

/// ONBOARDING – 3 schermate stile Revolut
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  void _next() {
    if (_page < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _OnboardingPage(
        title: 'Investi senza complicazioni',
        subtitle:
            'Collega il broker, imposta un obiettivo e ti facciamo vedere cosa fare passo passo.',
        icon: Icons.show_chart,
      ),
      _OnboardingPage(
        title: 'Obiettivi chiari',
        subtitle:
            'Viaggio, casa, fondo emergenze: segui i tuoi obiettivi invece dei grafici complicati.',
        icon: Icons.flag_circle,
      ),
      _OnboardingPage(
        title: 'Inizia con poco',
        subtitle:
            'Anche 25€/mese con un PAC. Pensiamo noi alla parte tecnica, tu pensi al perché investire.',
        icon: Icons.savings,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Logo in alto
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.asset(
                    'assets/logo_investly.PNG',
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Investly',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                itemCount: pages.length,
                itemBuilder: (_, i) => pages[i],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  height: 6,
                  width: _page == i ? 20 : 8,
                  decoration: BoxDecoration(
                    color: _page == i
                        ? const Color(0xFF00D26A)
                        : Colors.white24,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00D26A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(_page < 2 ? 'Avanti' : 'Entra in Investly'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const _OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: const Color(0xFF00D26A)),
          const SizedBox(height: 32),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

/// DASHBOARD + BOTTOM NAV

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _HomeTab(),
      const PortfolioScreen(),
      const GoalsScreen(),
      const BrokersScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Investly'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white12,
              child: Icon(Icons.person, size: 16),
            ),
          )
        ],
      ),
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        backgroundColor: const Color(0xFF0B0C0F),
        selectedItemColor: const Color(0xFF00D26A),
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: 'Portafoglio'),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Obiettivi'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: 'Broker'),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF12141A),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Valore totale',
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
              SizedBox(height: 8),
              Text('€ 12.450',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('+7,4% negli ultimi 12 mesi',
                  style: TextStyle(color: Color(0xFF00D26A), fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF12141A),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Allocazione',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              SizedBox(height: 8),
              Text('ETF 60%  •  Azioni 30%  •  Cash 10%',
                  style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text('Notifiche',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        const _NotificationTile(
            text: 'Il tuo obiettivo "Viaggio Giappone" è al 35%.'),
        const _NotificationTile(
            text: 'PAC simulato: ad oggi avresti versato 2.400€'),
        const _NotificationTile(
            text: 'Mercati stabili oggi. Nessuna azione urgente.'),
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final String text;
  const _NotificationTile({required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: const Icon(Icons.notifications_none, color: Colors.white70),
      title: Text(text,
          style: const TextStyle(color: Colors.white70, fontSize: 14)),
    );
  }
}

/// PORTAFOGLIO

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'name': 'Portafoglio Conservativo',
        'desc': 'Più obbligazioni, meno volatilità',
        'premium': false
      },
      {
        'name': 'Portafoglio Bilanciato',
        'desc': 'Equilibrio rischio / rendimento',
        'premium': false
      },
      {
        'name': 'Portafoglio Aggressivo',
        'desc': 'Più azioni, crescita potenziale',
        'premium': false
      },
      {
        'name': 'Portafoglio Tech (Premium)',
        'desc': 'Focus su tecnologia globale',
        'premium': true
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final p = items[i];
        final bool premium = p['premium'] as bool;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF12141A),
            borderRadius: BorderRadius.circular(16),
            border: premium
                ? Border.all(color: const Color(0xFF00D26A), width: 1)
                : null,
          ),
          child: ListTile(
            title: Text(p['name'] as String,
                style: const TextStyle(color: Colors.white)),
            subtitle: Text(p['desc'] as String,
                style: const TextStyle(color: Colors.white70)),
            trailing: premium
                ? const Icon(Icons.lock, color: Colors.white54)
                : TextButton(
                    onPressed: () {},
                    child: const Text('Seleziona'),
                  ),
          ),
        );
      },
    );
  }
}

/// OBIETTIVI

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final goals = [
      {
        'title': 'Viaggio in Giappone',
        'current': 2100,
        'target': 6000,
        'date': 'Giugno 2026'
      },
      {
        'title': 'Fondo emergenze',
        'current': 700,
        'target': 1000,
        'date': 'Senza scadenza'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: goals.length,
      itemBuilder: (_, i) {
        final g = goals[i];
        final progress = (g['current'] as int) / (g['target'] as int);
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF12141A),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(g['title'] as String,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Text(g['date'] as String,
                  style: const TextStyle(color: Colors.white54, fontSize: 12)),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: progress,
                color: const Color(0xFF00D26A),
                backgroundColor: Colors.white10,
              ),
              const SizedBox(height: 8),
              Text(
                '€ ${g['current']} / € ${g['target']}',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// BROKER

class BrokersScreen extends StatelessWidget {
  const BrokersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brokers = [
      {
        'name': 'Trade Republic',
        'desc': 'Mobile-first, ideale per PAC e piccoli importi.',
        'area': 'EU / Italia'
      },
      {
        'name': 'Scalable Capital',
        'desc': 'Ottimo per ETF e portafogli semplici.',
        'area': 'EU / Italia'
      },
      {
        'name': 'DEGIRO',
        'desc': 'Più completo, adatto a chi vuole più mercati.',
        'area': 'EU'
      },
      {
        'name': 'eToro',
        'desc': 'Social trading, copy portfolio.',
        'area': 'Globale'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: brokers.length,
      itemBuilder: (_, i) {
        final b = brokers[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF12141A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            title: Text(b['name'] as String,
                style: const TextStyle(color: Colors.white)),
            subtitle: Text(
              '${b['desc']} \nArea consigliata: ${b['area']}',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        );
      },
    );
  }
}