import 'dart:convert';

import 'package:camwater_application/models/production.dart';
import 'package:camwater_application/services/production.dart';
import 'package:camwater_application/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  late Future<List<dynamic>> futureProduction;
  late List<dynamic> _productions;
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  late bool _isUpdating;
  late TextEditingController _id;
  late TextEditingController eau_brute;
  late TextEditingController eau_traite;
  late TextEditingController pompe_lavage;
  late TextEditingController horaire_agitateur;
  late TextEditingController horaire_pompe_doseuse;
  late TextEditingController horaire_pompe_refoulement;
  late TextEditingController stock_produit;
  late TextEditingController index_eneo;

  _getProductions() {
    Production.fetchProductions().then((productions) {
      setState(() {
        _productions = productions;
        /*for (int i = 0; i < _productions.length; i++) {
          _productions[i] = productions[i];
          print('val ${i}: ${_productions[i]}');
        }
        print(_productions);*/
      });
    });
  }

  _updateProduction(List<dynamic> production) {
    setState(() {
      _isUpdating = true;
    });
    Production.updateProductions(
            _id.text,
            eau_brute.text,
            eau_traite.text,
            pompe_lavage.text,
            horaire_agitateur.text,
            horaire_pompe_doseuse.text,
            horaire_pompe_refoulement.text,
            stock_produit.text,
            index_eneo.text)
        .then((result) {
      if ('success' == result) {
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _clearValues() {
    _id.text = '';
    eau_brute.text = '';
    eau_traite.text = '';
    pompe_lavage.text = '';
    horaire_agitateur.text = '';
    horaire_pompe_doseuse.text = '';
    horaire_pompe_refoulement.text = '';
    stock_produit.text = '';
    index_eneo.text = '';
  }

  _showValues(Productions production) {
    _id.text = production.id.toString();
    eau_brute.text = production.eau_brute;
    eau_traite.text = production.eau_traite;
    pompe_lavage.text = production.pompe_lavage;
    horaire_agitateur.text = production.horaire_agitateur;
    horaire_pompe_doseuse.text = production.horaire_pompe_doseuse;
    horaire_pompe_refoulement.text = production.horaire_pompe_refoulement;
    stock_produit.text = production.stock_produit;
    index_eneo.text = production.index_eneo;
  }

  @override
  void initState() {
    super.initState();
    _productions = [];
    _isUpdating = false;
    _id = TextEditingController();
    eau_brute = TextEditingController();
    eau_traite = TextEditingController();
    pompe_lavage = TextEditingController();
    horaire_agitateur = TextEditingController();
    horaire_pompe_doseuse = TextEditingController();
    horaire_pompe_refoulement = TextEditingController();
    stock_produit = TextEditingController();
    index_eneo = TextEditingController();
    futureProduction = Production.fetchProductions();
    _getProductions();
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          sortAscending: true,
          columns: [
            DataColumn(label: Text('Indice')),
            DataColumn(label: Text('Eau brute')),
            DataColumn(label: Text('Eau traitée')),
            DataColumn(label: Text('Pompe lavage')),
            DataColumn(label: Text('Horaire agitateur')),
            DataColumn(label: Text('Horaire pompe doseuse')),
            DataColumn(label: Text('Horaire pompe refoulement')),
            DataColumn(label: Text('Stock produit')),
            DataColumn(label: Text('Index eneo')),
            DataColumn(label: Text('Action')),
          ],
          rows: _productions
              .map(
                (production) => DataRow(
                    cells: [
                      DataCell(
                        Text('#' + production['id'].toString()),
                      ),
                      DataCell(
                        Text(production['eau_brute'].toString()),
                      ),
                      DataCell(
                        Text(production['eau_traite'].toString()),
                      ),
                      DataCell(
                        Text(production['pompe_lavage'].toString()),
                      ),
                      DataCell(
                        Text(production['horaire_agitateur'].toString()),
                      ),
                      DataCell(
                        Text(production['horaire_pompe_doseuse'].toString()),
                      ),
                      DataCell(
                        Text(
                            production['horaire_pompe_refoulement'].toString()),
                      ),
                      DataCell(
                        Text(production['stock_produit'].toString()),
                      ),
                      DataCell(
                        Text(production['index_eneo'].toString()),
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _updateProduction(_productions);
                          },
                        ),
                      ),
                    ],
                    selected: selected[_productions.length],
                    onSelectChanged: (bool? value) {
                      setState(() {
                        selected[production['id']] = value!;
                      });
                    }),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 100, 0, 1),
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'Production',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Liste production',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              _dataBody(),
            ],
          ),
        ));
  }
}
