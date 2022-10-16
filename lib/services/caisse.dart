import 'dart:convert';

import 'package:camwater_application/models/caisse.dart';
import 'package:http/http.dart' as http;

import 'globals.dart';

class Caisse {
  static Future<http.Response> caisse(String recette, String depense,
      String encaissement, String branchement, String abonnement) async {
    Map data = {
      "recette": recette,
      "depense": depense,
      "encaissement": encaissement,
      "branchement": branchement,
      "abonnement": abonnement,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'caisses');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<List<dynamic>> fetchCaisses() async {
    var url = Uri.parse(baseURL + 'caisses');
    http.Response response =
        await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print('premier test');
      final Map<String, dynamic> maps =
          jsonDecode((response.body)) as Map<String, dynamic>;
      for (int i = 0; i < maps['data'].length; i++) {
        print('resultat${i}: ${maps['data'][i]['recette']}');
      }
      print('troisieme test');
      return maps['data'];
    } else {
      throw Exception('Failed to load caisse');
    }
  }

  static Future<Caisses> updateCaisses(
      String id,
      String recette,
      String depense,
      String encaissement,
      String branchement,
      String abonnement) async {
    var url = Uri.parse(baseURL + 'caisses/${id}');
    Map data = {
      "id": id,
      "recette": recette,
      "depense": depense,
      "encaissement": encaissement,
      "branchement": branchement,
      "abonnement": abonnement,
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
      print('update tree test ${Caisses.fromJson(jsonDecode(response.body))}');
      return Caisses.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update caisse');
    }
  }

  /*static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }*/
}
