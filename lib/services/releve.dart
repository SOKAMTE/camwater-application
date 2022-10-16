import 'dart:convert';

import 'package:camwater_application/models/Releve.dart';
import 'package:http/http.dart' as http;

import 'globals.dart';

class Releve {
  static Future<http.Response> releve(
      String nom_agence,
      String code_agence,
      String nom_releveur,
      String numero_compteur,
      String nom_prenom,
      String reference_abonne,
      String ancien_index,
      String nouvel_index,
      String anomalie,
      String photo) async {
    Map data = {
      "nom_agence": nom_agence,
      "code_agence": code_agence,
      "nom_releveur": nom_releveur,
      "numero_compteur": numero_compteur,
      "nom_prenom": nom_prenom,
      "reference_abonne": reference_abonne,
      "ancien_index": ancien_index,
      "nouvel_index": nouvel_index,
      "anomalie": anomalie,
      "photo": photo,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'releves');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<List<dynamic>> fetchReleves() async {
    var url = Uri.parse(baseURL + 'releves');
    http.Response response =
        await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print('premier test');
      final Map<String, dynamic> maps =
          jsonDecode((response.body)) as Map<String, dynamic>;
      for (int i = 0; i < maps['data'].length; i++) {
        print('resultat${i}: ${maps['data'][i]['eau_brute']}');
      }
      print('troisieme test');
      return maps['data'];
    } else {
      throw Exception('Failed to load Releve');
    }
  }

  static Future<Releves> updateReleves(
      String id,
      String nom_agence,
      String code_agence,
      String nom_releveur,
      String numero_compteur,
      String nom_prenom,
      String reference_abonne,
      String ancien_index,
      String nouvel_index,
      String anomalie,
      String photo) async {
    var url = Uri.parse(baseURL + 'Releves/${id}');
    Map data = {
      "id": id,
      "nom_agence": nom_agence,
      "code_agence": code_agence,
      "nom_releveur": nom_releveur,
      "numero_compteur": numero_compteur,
      "nom_prenom": nom_prenom,
      "reference_abonne": reference_abonne,
      "ancien_index": ancien_index,
      "nouvel_index": nouvel_index,
      "anomalie": anomalie,
      "photo": photo,
    };
    var body = json.encode(data);
    http.Response response = await http.put(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print('update test');
      /*final Map<String, dynamic> maps =
          jsonDecode((response.body)) as Map<String, dynamic>;
      for (int i = 0; i < maps['data'].length; i++) {
        print('resultat${i}: ${maps['data'][i]['recette']}');
      }*/
      print('update tree test ${Releves.fromJson(jsonDecode(response.body))}');
      return Releves.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update Releve');
    }
  }
}
