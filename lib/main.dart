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
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFF00D26A),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/logo_investly.PNG",
          width: 160,
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo_investly.PNG", width: 120),
            const SizedBox(height: 25),
            const Text(
              "Benvenuto in Investly",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "La prima app pensata per aiutarti a costruire un futuro finanziario semplice e potente.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00D26A),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GoalsPage()),
                );
              },
              child: const Text("Inizia"),
            ),
          ],
        ),
      ),
    );
  }
}

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("I tuoi obiettivi")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Qual è il tuo obiettivo finanziario principale?",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 25),
            goalCard(
              context,
              "Risparmiare",
              "Crea il tuo primo piccolo capitale",
            ),
            goalCard(
              context,
              "Investire nel lungo periodo",
              "Costruisci portafogli solidi e diversificati",
            ),
            goalCard(
              context,
              "Raggiungere un obiettivo",
              "Vacanze, auto, università…",
            ),
          ],
        ),
      ),
    );
  }

  Widget goalCard(BuildContext context, String title, String subtitle) {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DashboardPage()),
          );
        },
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard Investly")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Il tuo portafoglio",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.grey[900],
              child: const ListTile(
                title: Text("Valore totale (simulato): 7.540€"),
                subtitle: Text("Rendimento annuale stimato: +7.2%"),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Broker consigliati",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            brokerCard("Trade Republic", "Semplice, zero commissioni"),
            brokerCard("Scalable Capital", "PAC automatici e ETF"),
            brokerCard("Degiro", "Per chi vuole più controllo"),
          ],
        ),
      ),
    );
  }

  Widget brokerCard(String name, String subtitle) {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        title: Text(name, style: const TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}
