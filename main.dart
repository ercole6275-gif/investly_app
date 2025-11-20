
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash.dart';
import 'services/demo_service.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => DemoService(), child: InvestlyApp()));
}

class InvestlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investly Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF3A7AFE),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.interTextTheme(),
        appBarTheme: AppBarTheme(color: Colors.white, foregroundColor: Colors.black, elevation: 0),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF3A7AFE),
        scaffoldBackgroundColor: Color(0xFF0E0E0E),
        textTheme: GoogleFonts.interTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
        appBarTheme: AppBarTheme(color: Color(0xFF0E0E0E), foregroundColor: Colors.white, elevation: 0),
      ),
      themeMode: ThemeMode.system,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
