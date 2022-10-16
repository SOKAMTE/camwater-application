import 'dart:convert';

import 'package:camwater_application/rounded_button.dart';
import 'package:camwater_application/screens/statement/index_screen.dart';
import 'package:camwater_application/services/globals.dart';
import 'package:camwater_application/services/releve.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatementScreen extends StatefulWidget {
  const StatementScreen({Key? key}) : super(key: key);

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  String val = '';
  String dropdownValue = 'One';
  String nom_agence = '';
  String code_agence = '';
  String nom_releveur = '';
  String numero_compteur = '';
  String nom_prenom = '';
  String reference_abonne = '';
  String ancien_index = '';
  String nouvel_index = '';
  String anomalie = '';
  String photo = '';

  relevePressed() async {
    if (nom_agence.isNotEmpty &&
        code_agence.isNotEmpty &&
        nom_releveur.isNotEmpty &&
        numero_compteur.isNotEmpty &&
        nom_prenom.isNotEmpty &&
        reference_abonne.isNotEmpty &&
        ancien_index.isNotEmpty &&
        photo.isNotEmpty &&
        nouvel_index.isNotEmpty &&
        anomalie.isNotEmpty) {
      http.Response response = await Releve.releve(
          nom_agence,
          code_agence,
          nom_releveur,
          numero_compteur,
          nom_prenom,
          reference_abonne,
          ancien_index,
          nouvel_index,
          anomalie,
          photo);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Index(),
            ));
      } else {
        errorSnackBar(context, responseMap.values.first);
      }
    } else {
      errorSnackBar(context, 'enter all required fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 100, 0, 1),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Relevé',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 3,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Nom agence',
              ),
              onChanged: (value) {
                nom_agence = value;
              },
            ),
            const SizedBox(
              height: 3,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Code agence',
              ),
              onChanged: (value) {
                code_agence = value;
              },
            ),
            const SizedBox(
              height: 3,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Nom releveur',
              ),
              onChanged: (value) {
                nom_releveur = value;
              },
            ),
            const SizedBox(
              height: 3,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Numero compteur',
              ),
              onChanged: (value) {
                numero_compteur = value;
              },
            ),
            const SizedBox(
              height: 3,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Nom et prenom',
              ),
              onChanged: (value) {
                nom_prenom = value;
              },
            ),
            const SizedBox(
              height: 3,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Reference abonné',
              ),
              onChanged: (value) {
                reference_abonne = value;
              },
            ),
            const SizedBox(
              height: 3,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Ancien index',
              ),
              onChanged: (value) {
                ancien_index = value;
              },
            ),
            const SizedBox(
              height: 3,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Nouvel index',
              ),
              onChanged: (value) {
                nouvel_index = value;
              },
            ),
            const SizedBox(
              height: 3,
            ),
            DropdownButton<String>(
              hint: Text("Selectionnez une anomalie"),
              dropdownColor: Colors.white,
              value: dropdownValue,
              isExpanded: true,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              underline: Container(
                height: 2,
                color: Colors.grey,
              ),
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
                anomalie = dropdownValue;
              },
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 3,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Photo',
              ),
              onChanged: (value) {
                photo = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            RoundedButton(
              btnText: 'Suivant',
              onBtnPressed: () => relevePressed(),
            ),
            const SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }
}
