
import 'package:flutter/material.dart';

class DemoService extends ChangeNotifier {
  double total = 3240.0;
  double monthChangePct = 2.3;
  Map<String,double> allocation = {'ETF':60,'Stocks':30,'Cash':10};

  List<Map> notifications = [
    {'title':'Il tuo obiettivo Viaggio è al 35%'},
    {'title':'Mercati stabili oggi'},
    {'title':'PAC simulato eseguito'}
  ];

  List<Map> portfolios = [
    {'key':'conservativo','name':'Conservativo','description':'Stabilità, low risk','is_premium':false},
    {'key':'bilanciato','name':'Bilanciato','description':'Equilibrio rischio/rendimento','is_premium':false},
    {'key':'aggressivo','name':'Aggressivo','description':'Massima crescita','is_premium':false},
    {'key':'tech','name':'Tech (Premium)','description':'Settore tecnologia','is_premium':true},
    {'key':'esg','name':'ESG (Premium)','description':'Sostenibile','is_premium':true},
  ];

  List<Map> objectives = [
    {'id':1,'title':'Viaggio Giappone','target':6000,'current':2100,'deadline':'2026-06-01'},
    {'id':2,'title':'Fondo emergenze','target':1000,'current':700,'deadline':null},
  ];

  List<Map> brokers = [
    {'key':'scalable','name':'Scalable Capital','description':'Broker popolare in Italia','link':'https://scalable.capital'},
    {'key':'degiro','name':'DEGIRO','description':'Broker europeo','link':'https://www.degiro.com'},
    {'key':'interactive','name':'Interactive Brokers','description':'Broker globale','link':'https://www.interactivebrokers.com'},
    {'key':'etoro','name':'eToro','description':'Social trading','link':'https://www.etoro.com'},
    {'key':'trade_republic','name':'Trade Republic','description':'Mobile-first broker','link':'https://www.traderepublic.com'},
  ];

  void togglePremium() { /* simulate */ notifyListeners(); }
  void addObjective(Map obj) { objectives.add(obj); notifyListeners(); }
}
