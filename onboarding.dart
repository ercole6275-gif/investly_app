
import 'package:flutter/material.dart';

class OnboardingFlow extends StatefulWidget {
  @override
  _OnboardingFlowState createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pc = PageController();
  Map answers = {};
  int page = 0;

  void next() {
    if (page < 6) {
      _pc.nextPage(duration: Duration(milliseconds:300), curve: Curves.easeInOut);
      setState(()=>page+=1);
    } else {
      Navigator.of(context).pop();
    }
  }

  Widget _buildStep(String title, List<String> options) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(children: [
        SizedBox(height:16),
        Text(title, style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
        SizedBox(height:12),
        ...options.map((o) => ListTile(
          title: Text(o),
          leading: Radio(value:o, groupValue: answers[title], onChanged: (v){ setState(()=>answers[title]=v); }),
        )),
        Spacer(),
        ElevatedButton(onPressed: next, child: Text('Avanti'))
      ]),
    );
  }

  Widget _buildSummary() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(children: [
        Text('Riepilogo', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
        SizedBox(height:12),
        Expanded(child: SingleChildScrollView(child: Text(answers.isEmpty ? 'Nessuna risposta' : answers.toString()))),
        ElevatedButton(onPressed: (){ Navigator.of(context).pop(); }, child: Text('Vai alla dashboard'))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Onboarding')),
      body: PageView(
        controller: _pc,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildStep('Obiettivo principale', ['Risparmiare','Investire nel tempo','Fondo emergenze','Guadagno a lungo termine','Non lo so']),
          _buildStep('Orizzonte temporale', ['<1 anno','1-3 anni','3-5 anni','5-10 anni','10+ anni']),
          _buildStep('Rischio', ['Preferisco stabilità','Oscillazioni moderate ok','Oscillazioni forti ok']),
          _buildStep('Importo iniziale', ['0-500','500-2000','2000-5000','5000+']),
          _buildStep('Importo mensile (PAC)', ['10','25','50','100','200']),
          _buildStep('Esperienza', ['No','Sì, ma poco','Sì, uso già un broker']),
          _buildSummary()
        ],
      ),
    );
  }
}
