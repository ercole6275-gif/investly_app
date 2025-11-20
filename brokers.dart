
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/demo_service.dart';

class BrokersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final svc = Provider.of<DemoService>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Broker')),
      body: ListView(padding: EdgeInsets.all(12), children: svc.brokers.map((b) => Card(child: ListTile(
        leading: Icon(Icons.business),
        title: Text(b['name']),
        subtitle: Text(b['description']),
        trailing: TextButton(onPressed: () async {
          final url = b['link'];
          if (await canLaunch(url)) await launch(url);
        }, child: Text('Collega')),
      ))).toList()),
    );
  }
}
