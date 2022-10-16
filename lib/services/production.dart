import 'dart:convert';

import 'package:camwater_application/models/Production.dart';
import 'package:http/http.dart' as http;

import 'globals.dart';

class Production {
  static Future<http.Response> production(
      String eau_brute,
      String eau_traite,
      String pompe_lavage,
      String horaire_agitateur,
      String horaire_pompe_doseuse,
      String horaire_pompe_refoulement,
      String stock_produit,
      String index_eneo) async {
    Map data = {
      "eau_brute": eau_brute,
      "eau_traite": eau_traite,
      "pompe_lavage": pompe_lavage,
      "horaire_agitateur": horaire_agitateur,
      "horaire_pompe_doseuse": horaire_pompe_doseuse,
      "horaire_pompe_refoulement": horaire_pompe_refoulement,
      "stock_produit": stock_produit,
      "index_eneo": index_eneo,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'productions');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<List<dynamic>> fetchProductions() async {
    var url = Uri.parse(baseURL + 'productions');
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
      throw Exception('Failed to load Production');
    }
  }

  static Future<Productions> updateProductions(
      String id,
      String eau_brute,
      String eau_traite,
      String pompe_lavage,
      String horaire_agitateur,
      String horaire_pompe_doseuse,
      String horaire_pompe_refoulement,
      String stock_produit,
      String index_eneo) async {
    var url = Uri.parse(baseURL + 'Productions/${id}');
    Map data = {
      "id": id,
      "eau_brute": eau_brute,
      "eau_traite": eau_traite,
      "pompe_lavage": pompe_lavage,
      "horaire_agitateur": horaire_agitateur,
      "horaire_pompe_doseuse": horaire_pompe_doseuse,
      "horaire_pompe_refoulement": horaire_pompe_refoulement,
      "stock_produit": stock_produit,
      "index_eneo": index_eneo,
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
          'update tree test ${Productions.fromJson(jsonDecode(response.body))}');
      return Productions.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update Production');
    }
  }
}
