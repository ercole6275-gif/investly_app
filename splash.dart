
import 'package:flutter/material.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(milliseconds:700), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(mainAxisSize: MainAxisSize.min, children:[
        Image.asset('assets/logo.png', width:96, height:96),
        SizedBox(height:12),
        Text('Investly', style: TextStyle(fontSize:24, fontWeight: FontWeight.bold)),
        SizedBox(height:6),
        Text('Investire, semplice', style: TextStyle(fontSize:16, color: Colors.grey))
      ])),
    );
  }
}
