
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/demo_service.dart';
import 'portfolios.dart';
import 'objectives.dart';
import 'brokers.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final svc = Provider.of<DemoService>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Investly')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children:[
          Card(child: Padding(padding: EdgeInsets.all(16), child: Row(children:[
            Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
              Text('Totale portafoglio', style: TextStyle(fontSize:16)),
              SizedBox(height:8),
              Text('${svc.total.toStringAsFixed(0)}€', style: TextStyle(fontSize:24, fontWeight: FontWeight.bold)),
              SizedBox(height:4),
              Text('+${svc.monthChangePct}% questo mese', style: TextStyle(color: Colors.green))
            ]),
            Spacer(),
            Icon(Icons.show_chart, size:48)
          ]))),
          SizedBox(height:12),
          Card(child: Padding(padding: EdgeInsets.all(12), child: Row(children:[
            Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Text('Allocazione'), SizedBox(height:8), Text('ETF ${svc.allocation['ETF'].toInt()}%  Azioni ${svc.allocation['Stocks'].toInt()}%  Cash ${svc.allocation['Cash'].toInt()}%')]),
            Spacer(),
            Icon(Icons.pie_chart)
          ]))),
          SizedBox(height:12),
          Expanded(child: ListView(children: [
            ...svc.notifications.map((n) => ListTile(title: Text(n['title']))).toList()
          ]))
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label:'Portafogli'),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label:'Obiettivi'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label:'Broker'),
        ],
        onTap: (i){
          if (i==1) Navigator.of(context).push(MaterialPageRoute(builder: (_) => PortfoliosScreen()));
          if (i==2) Navigator.of(context).push(MaterialPageRoute(builder: (_) => ObjectivesScreen()));
          if (i==3) Navigator.of(context).push(MaterialPageRoute(builder: (_) => BrokersScreen()));
        },
      ),
    );
  }
}
