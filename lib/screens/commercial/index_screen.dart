import 'dart:convert';

import 'package:camwater_application/models/commercial.dart';
import 'package:camwater_application/services/commercial.dart';
import 'package:camwater_application/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  late Future<List<dynamic>> futureCommercial;
  late List<dynamic> _commercials;
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
  late bool _isUpdating;
  late TextEditingController _id;
  late TextEditingController devis_branchement;
  late TextEditingController abonnement;
  late TextEditingController fiche_poste;
  late TextEditingController depose_compteur;
  late TextEditingController rapport_activite;

  _getCommercials() {
    Commercial.fetchCommercials().then((commercials) {
      setState(() {
        _commercials = commercials;
        /*for (int i = 0; i < _commercials.length; i++) {
          _commercials[i] = commercials[i];
          print('val ${i}: ${_commercials[i]}');
        }
        print(_commercials);*/
      });
    });
  }

  _updateCommercial(List<dynamic> commercial) {
    setState(() {
      _isUpdating = true;
    });
    Commercial.updateCommercials(
            _id.text,
            devis_branchement.text,
            abonnement.text,
            fiche_poste.text,
            depose_compteur.text,
            rapport_activite.text)
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
    devis_branchement.text = '';
    abonnement.text = '';
    fiche_poste.text = '';
    depose_compteur.text = '';
    rapport_activite.text = '';
  }

  _showValues(Commercials commercial) {
    _id.text = commercial.id.toString();
    devis_branchement.text = commercial.devis_branchement;
    abonnement.text = commercial.abonnement;
    fiche_poste.text = commercial.fiche_poste;
    depose_compteur.text = commercial.depose_compteur;
    rapport_activite.text = commercial.rapport_activite;
  }

  @override
  void initState() {
    super.initState();
    _commercials = [];
    _isUpdating = false;
    _id = TextEditingController();
    devis_branchement = TextEditingController();
    abonnement = TextEditingController();
    fiche_poste = TextEditingController();
    depose_compteur = TextEditingController();
    rapport_activite = TextEditingController();
    futureCommercial = Commercial.fetchCommercials();
    _getCommercials();
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
            DataColumn(label: Text('Devis branchement')),
            DataColumn(label: Text('Abonnement')),
            DataColumn(label: Text('Fiche poste')),
            DataColumn(label: Text('Depose compteur')),
            DataColumn(label: Text('Rapport activite')),
            DataColumn(label: Text('Action')),
          ],
          rows: _commercials
              .map(
                (commercial) => DataRow(
                    cells: [
                      DataCell(
                        Text('#' + commercial['id'].toString()),
                      ),
                      DataCell(
                        Text(commercial['devis_branchement'].toString()),
                      ),
                      DataCell(
                        Text(commercial['abonnement'].toString()),
                      ),
                      DataCell(
                        Text(commercial['fiche_poste'].toString()),
                      ),
                      DataCell(
                        Text(commercial['depose_compteur'].toString()),
                      ),
                      DataCell(
                        Text(commercial['rapport_activite'].toString()),
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _updateCommercial(_commercials);
                          },
                        ),
                      ),
                    ],
                    selected: selected[_commercials.length],
                    onSelectChanged: (bool? value) {
                      setState(() {
                        selected[commercial['id']] = value!;
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
            'Commercial',
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
                'Liste commercial',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              _dataBody(),
            ],
          ),
        ));
  }
}
