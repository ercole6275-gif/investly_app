
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/demo_service.dart';

class ObjectivesScreen extends StatefulWidget {
  @override
  _ObjectivesScreenState createState() => _ObjectivesScreenState();
}
class _ObjectivesScreenState extends State<ObjectivesScreen> {
  @override
  Widget build(BuildContext context) {
    final svc = Provider.of<DemoService>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Obiettivi')),
      body: ListView(padding: EdgeInsets.all(12), children: svc.objectives.map((o) => Card(child: ListTile(
        title: Text(o['title']),
        subtitle: Text('Progress: ' + ((o['current']).toString())),
      ))).toList()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final newObj = {'id': DateTime.now().millisecondsSinceEpoch, 'title':'Nuovo obiettivo','target':1000,'current':0,'deadline':null};
          Provider.of<DemoService>(context, listen:false).addObjective(newObj);
        },
      ),
    );
  }
}
