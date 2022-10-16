import 'dart:convert';

import 'package:camwater_application/models/caisse.dart';
import 'package:camwater_application/services/caisse.dart';
import 'package:camwater_application/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  late Future<List<dynamic>> futureCaisse;
  late List<dynamic> _caisses;
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  late bool _isUpdating;
  late TextEditingController _id;
  late TextEditingController _recette;
  late TextEditingController _depense;
  late TextEditingController _encaissement;
  late TextEditingController _branchement;
  late TextEditingController _abonnement;

  _getCaisses() {
    Caisse.fetchCaisses().then((caisses) {
      setState(() {
        _caisses = caisses;
        /*for (int i = 0; i < _caisses.length; i++) {
          _caisses[i] = caisses[i];
          print('val ${i}: ${_caisses[i]}');
        }
        print(_caisses);*/
      });
    });
  }

  _updateCaisse(List<dynamic> caisse) {
    setState(() {
      _isUpdating = true;
    });
    Caisse.updateCaisses(_id.text, _recette.text, _depense.text,
            _encaissement.text, _branchement.text, _abonnement.text)
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
    _recette.text = '';
    _depense.text = '';
    _encaissement.text = '';
    _branchement.text = '';
    _abonnement.text = '';
  }

  _showValues(Caisses caisse) {
    _id.text = caisse.id.toString();
    _recette.text = caisse.recette;
    _depense.text = caisse.depense;
    _encaissement.text = caisse.encaissement;
    _branchement.text = caisse.branchement;
    _abonnement.text = caisse.abonnement;
  }

  @override
  void initState() {
    super.initState();
    _caisses = [];
    _isUpdating = false;
    _id = TextEditingController();
    _recette = TextEditingController();
    _depense = TextEditingController();
    _encaissement = TextEditingController();
    _branchement = TextEditingController();
    _abonnement = TextEditingController();
    futureCaisse = Caisse.fetchCaisses();
    _getCaisses();
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
            DataColumn(label: Text('Recette')),
            DataColumn(label: Text('Depense')),
            DataColumn(label: Text('Encaissement')),
            DataColumn(label: Text('Branchement')),
            DataColumn(label: Text('Abonnement')),
            DataColumn(label: Text('Action')),
          ],
          rows: _caisses
              .map(
                (caisse) => DataRow(
                    cells: [
                      DataCell(
                        Text('#' + caisse['id'].toString()),
                      ),
                      DataCell(
                        Text(caisse['recette'].toString()),
                      ),
                      DataCell(
                        Text(caisse['depense'].toString()),
                      ),
                      DataCell(
                        Text(caisse['encaissement'].toString()),
                      ),
                      DataCell(
                        Text(caisse['branchement'].toString()),
                      ),
                      DataCell(
                        Text(caisse['abonnement'].toString()),
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _updateCaisse(_caisses);
                          },
                        ),
                      ),
                    ],
                    selected: selected[_caisses.length],
                    onSelectChanged: (bool? value) {
                      setState(() {
                        selected[caisse['id']] = value!;
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
            'Caisse',
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
                'Liste caisse',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              _dataBody(),
            ],
          ),
        ));
  }
}
