import 'dart:convert';

import 'package:camwater_application/rounded_button.dart';
import 'package:camwater_application/screens/box/index_screen.dart';
import 'package:camwater_application/services/caisse.dart';
import 'package:camwater_application/services/globals.dart';
import 'package:camwater_application/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BoxScreen extends StatefulWidget {
  const BoxScreen({Key? key}) : super(key: key);

  @override
  State<BoxScreen> createState() => _BoxScreenState();
}

class _BoxScreenState extends State<BoxScreen> {
  String _recette = '';
  String _depense = '';
  String _encaissement = '';
  String _branchement = '';
  String _abonnement = '';

  caissePressed() async {
    if (_recette.isNotEmpty &&
        _depense.isNotEmpty &&
        _encaissement.isNotEmpty &&
        _branchement.isNotEmpty &&
        _abonnement.isNotEmpty) {
      http.Response response = await Caisse.caisse(
          _recette, _depense, _encaissement, _branchement, _abonnement);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Recettes',
              ),
              onChanged: (value) {
                _recette = value;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Dépenses',
              ),
              onChanged: (value) {
                _depense = value;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Encaissements',
              ),
              onChanged: (value) {
                _encaissement = value;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Branchements',
              ),
              onChanged: (value) {
                _branchement = value;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Abonnements',
              ),
              onChanged: (value) {
                _abonnement = value;
              },
            ),
            const SizedBox(
              height: 45,
            ),
            RoundedButton(
              btnText: 'Valider',
              //onBtnPressed: () => Navigator.pushNamed(context, 'login'),
              onBtnPressed: () => caissePressed(),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
