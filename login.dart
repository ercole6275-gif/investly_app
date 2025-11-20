
import 'package:flutter/material.dart';
import 'onboarding.dart';
import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(children:[
              Image.asset('assets/logo.png', width:84,height:84),
              SizedBox(height:12),
              TextField(controller: _email, decoration: InputDecoration(labelText:'Email')),
              SizedBox(height:8),
              TextField(controller: _password, decoration: InputDecoration(labelText:'Password'), obscureText: true),
              SizedBox(height:16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => DashboardScreen()));
                },
                child: loading ? CircularProgressIndicator(color: Colors.white) : Text('Accedi')
              ),
              SizedBox(height:8),
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => OnboardingFlow()));
              }, child: Text('Registrati / Inizia onboarding'))
            ]),
          ),
        ),
      ),
    );
  }
}
