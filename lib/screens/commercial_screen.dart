import 'dart:convert';

import 'package:camwater_application/rounded_button.dart';
import 'package:camwater_application/screens/commercial/index_screen.dart';
import 'package:camwater_application/services/commercial.dart';
import 'package:camwater_application/services/globals.dart';
import 'package:camwater_application/widget/navigation_drawer_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommercialScreen extends StatefulWidget {
  const CommercialScreen({Key? key}) : super(key: key);

  @override
  State<CommercialScreen> createState() => _CommercialScreenState();
}

class _CommercialScreenState extends State<CommercialScreen> {
  String? path;
  void _pickFie() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        dialogTitle: 'Select a File for our app',
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'gif']);
    if (result == null) return;
    for (PlatformFile file in result.files) {
      print(file.path);
      path = file.path;
      print('chemin: ${path}');
    }
  }

  String devis_branchement = '';
  String abonnement = '';
  String fiche_poste = '';
  String depose_compteur = '';
  String rapport_activite = '';

  commercialPressed() async {
    if (devis_branchement.isNotEmpty &&
        abonnement.isNotEmpty &&
        fiche_poste.isNotEmpty &&
        depose_compteur.isNotEmpty &&
        rapport_activite.isNotEmpty) {
      http.Response response = await Commercial.commercial(devis_branchement,
          abonnement, fiche_poste, depose_compteur, rapport_activite);
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
        title: Text(
          'Commercial',
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
            ElevatedButton(
                onPressed: () async {
                  _pickFie();
                },
                child: const Text('open File')),
            const SizedBox(
              height: 25,
            ),
            /*Card(
              child: Image.asset('$path'),
            ),*/
            TextField(
              decoration: InputDecoration(
                hintText: 'Devis branchement',
              ),
              onChanged: (value) {
                devis_branchement = value;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Abonnement',
              ),
              onChanged: (value) {
                abonnement = value;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Fiche de pose',
              ),
              onChanged: (value) {
                fiche_poste = value;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Dépose compteur',
              ),
              onChanged: (value) {
                depose_compteur = value;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Rapport activité',
              ),
              onChanged: (value) {
                rapport_activite = value;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            RoundedButton(
              btnText: 'Valider',
              onBtnPressed: () => commercialPressed(),
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
