import 'dart:convert';

import 'package:camwater_application/models/Commercial.dart';
import 'package:http/http.dart' as http;

import 'globals.dart';

class Commercial {
  static Future<http.Response> commercial(
      String devis_branchement,
      String abonnement,
      String fiche_poste,
      String depose_compteur,
      String rapport_activite) async {
    Map data = {
      "devis_branchement": devis_branchement,
      "abonnement": abonnement,
      "fiche_poste": fiche_poste,
      "depose_compteur": depose_compteur,
      "rapport_activite": rapport_activite,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'commercials');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<List<dynamic>> fetchCommercials() async {
    var url = Uri.parse(baseURL + 'commercials');
    http.Response response =
        await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print('premier test');
      final Map<String, dynamic> maps =
          jsonDecode((response.body)) as Map<String, dynamic>;
      for (int i = 0; i < maps['data'].length; i++) {
        print('resultat${i}: ${maps['data'][i]['devis_branchement']}');
      }
      print('troisieme test');
      return maps['data'];
    } else {
      throw Exception('Failed to load Commercial');
    }
  }

  static Future<Commercials> updateCommercials(
      String id,
      String devis_branchement,
      String abonnement,
      String fiche_poste,
      String depose_compteur,
      String rapport_activite) async {
    var url = Uri.parse(baseURL + 'Commercials/${id}');
    Map data = {
      "id": id,
      "devis_branchement": devis_branchement,
      "abonnement": abonnement,
      "fiche_poste": fiche_poste,
      "depose_compteur": depose_compteur,
      "rapport_activite": rapport_activite,
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
      print(
          'update tree test ${Commercials.fromJson(jsonDecode(response.body))}');
      return Commercials.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update Commercial');
    }
  }
}
