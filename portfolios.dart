
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/demo_service.dart';

class PortfoliosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final svc = Provider.of<DemoService>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Portafogli')),
      body: ListView(padding: EdgeInsets.all(12), children: svc.portfolios.map((p) => Card(child: ListTile(
        title: Text(p['name']),
        subtitle: Text(p['description']),
        trailing: p['is_premium'] ? Icon(Icons.lock) : ElevatedButton(onPressed: (){}, child: Text('Seleziona')),
      ))).toList()),
    );
  }
}
