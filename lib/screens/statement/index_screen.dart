import 'dart:convert';

import 'package:camwater_application/models/releve.dart';
import 'package:camwater_application/services/releve.dart';
import 'package:camwater_application/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  late Future<List<dynamic>> futureReleve;
  late List<dynamic> _releves;
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  late bool _isUpdating;
  late TextEditingController _id;
  late TextEditingController nom_agence;
  late TextEditingController code_agence;
  late TextEditingController nom_releveur;
  late TextEditingController numero_compteur;
  late TextEditingController nom_prenom;
  late TextEditingController reference_abonne;
  late TextEditingController ancien_index;
  late TextEditingController nouvel_index;
  late TextEditingController anomalie;
  late TextEditingController photo;

  _getReleves() {
    Releve.fetchReleves().then((releves) {
      setState(() {
        _releves = releves;
        /*for (int i = 0; i < _releves.length; i++) {
          _releves[i] = releves[i];
          print('val ${i}: ${_releves[i]}');
        }
        print(_releves);*/
      });
    });
  }

  _updateReleve(List<dynamic> releve) {
    setState(() {
      _isUpdating = true;
    });
    Releve.updateReleves(
            _id.text,
            nom_agence.text,
            code_agence.text,
            nom_releveur.text,
            numero_compteur.text,
            nom_prenom.text,
            reference_abonne.text,
            ancien_index.text,
            nouvel_index.text,
            anomalie.text,
            photo.text)
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
    nom_agence.text = '';
    code_agence.text = '';
    nom_releveur.text = '';
    numero_compteur.text = '';
    nom_prenom.text = '';
    reference_abonne.text = '';
    ancien_index.text = '';
    nouvel_index.text = '';
    anomalie.text = '';
    photo.text = '';
  }

  _showValues(Releves releve) {
    _id.text = releve.id.toString();
    nom_agence.text = releve.nom_agence;
    code_agence.text = releve.code_agence;
    nom_releveur.text = releve.nom_releveur;
    numero_compteur.text = releve.numero_compteur;
    nom_prenom.text = releve.nom_prenom;
    reference_abonne.text = releve.reference_abonne;
    ancien_index.text = releve.ancien_index;
    nouvel_index.text = releve.nouvel_index;
    anomalie.text = releve.anomalie;
    photo.text = releve.photo;
  }

  @override
  void initState() {
    super.initState();
    _releves = [];
    _isUpdating = false;
    _id = TextEditingController();
    nom_agence = TextEditingController();
    code_agence = TextEditingController();
    nom_releveur = TextEditingController();
    numero_compteur = TextEditingController();
    nom_prenom = TextEditingController();
    reference_abonne = TextEditingController();
    ancien_index = TextEditingController();
    nouvel_index = TextEditingController();
    anomalie = TextEditingController();
    photo = TextEditingController();
    futureReleve = Releve.fetchReleves();
    _getReleves();
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
            DataColumn(label: Text('Nom agence')),
            DataColumn(label: Text('Code agence')),
            DataColumn(label: Text('Nom releveur')),
            DataColumn(label: Text('Numero compteur')),
            DataColumn(label: Text('Nom & Prenom')),
            DataColumn(label: Text('Reference abonné')),
            DataColumn(label: Text('Ancien index')),
            DataColumn(label: Text('Nouvel index')),
            DataColumn(label: Text('Anomalie')),
            DataColumn(label: Text('Photo')),
            DataColumn(label: Text('Action')),
          ],
          rows: _releves
              .map(
                (releve) => DataRow(
                    cells: [
                      DataCell(
                        Text('#' + releve['id'].toString()),
                      ),
                      DataCell(
                        Text(releve['nom_agence'].toString()),
                      ),
                      DataCell(
                        Text(releve['code_agence'].toString()),
                      ),
                      DataCell(
                        Text(releve['nom_releveur'].toString()),
                      ),
                      DataCell(
                        Text(releve['numero_compteur'].toString()),
                      ),
                      DataCell(
                        Text(releve['nom_prenom'].toString()),
                      ),
                      DataCell(
                        Text(releve['reference_abonne'].toString()),
                      ),
                      DataCell(
                        Text(releve['ancien_index'].toString()),
                      ),
                      DataCell(
                        Text(releve['nouvel_index'].toString()),
                      ),
                      DataCell(
                        Text(releve['anomalie'].toString()),
                      ),
                      DataCell(
                        Text(releve['photo'].toString()),
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _updateReleve(_releves);
                          },
                        ),
                      ),
                    ],
                    selected: selected[_releves.length],
                    onSelectChanged: (bool? value) {
                      setState(() {
                        selected[releve['id']] = value!;
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
            'Releve',
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
                'Liste releve',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              _dataBody(),
            ],
          ),
        ));
  }
}
