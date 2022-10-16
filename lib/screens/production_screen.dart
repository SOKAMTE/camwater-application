import 'dart:convert';

import 'package:camwater_application/rounded_button.dart';
import 'package:camwater_application/screens/production/index_screen.dart';
import 'package:camwater_application/services/globals.dart';
import 'package:camwater_application/services/production.dart';
import 'package:camwater_application/widget/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductionScreen extends StatefulWidget {
  const ProductionScreen({Key? key}) : super(key: key);

  @override
  State<ProductionScreen> createState() => _ProductionScreenState();
}

class _ProductionScreenState extends State<ProductionScreen> {
  String eau_brute = '';
  String eau_traite = '';
  String pompe_lavage = '';
  String horaire_agitateur = '';
  String horaire_pompe_doseuse = '';
  String horaire_pompe_refoulement = '';
  String stock_produit = '';
  String index_eneo = '';

  productionPressed() async {
    if (eau_brute.isNotEmpty &&
        eau_traite.isNotEmpty &&
        pompe_lavage.isNotEmpty &&
        horaire_agitateur.isNotEmpty &&
        horaire_pompe_doseuse.isNotEmpty &&
        horaire_pompe_refoulement.isNotEmpty &&
        stock_produit.isNotEmpty &&
        index_eneo.isNotEmpty) {
      http.Response response = await Production.production(
          eau_brute,
          eau_traite,
          pompe_lavage,
          horaire_agitateur,
          horaire_pompe_doseuse,
          horaire_pompe_refoulement,
          stock_produit,
          index_eneo);
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
            'Production',
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
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Eau brute',
                ),
                onChanged: (value) {
                  eau_brute = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Eau traitée',
                ),
                onChanged: (value) {
                  eau_traite = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Eau de lavage',
                ),
                onChanged: (value) {
                  pompe_lavage = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Horaire agitateurs',
                ),
                onChanged: (value) {
                  horaire_agitateur = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Horaires pompes doseuses',
                ),
                onChanged: (value) {
                  horaire_pompe_doseuse = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Horaires pompes de refoulement',
                ),
                onChanged: (value) {
                  horaire_pompe_refoulement = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Stocks produits',
                ),
                onChanged: (value) {
                  stock_produit = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Index enéo',
                ),
                onChanged: (value) {
                  index_eneo = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              RoundedButton(
                btnText: 'Valider',
                onBtnPressed: () => productionPressed(),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ));
  }
}
