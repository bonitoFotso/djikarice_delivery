import 'package:djikarice_delivery/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Importez cette bibliothèque pour utiliser jsonDecode

class MyApiTestingWidget extends StatefulWidget {
  const MyApiTestingWidget({super.key});

  @override
  _MyApiTestingWidgetState createState() => _MyApiTestingWidgetState();
}

class _MyApiTestingWidgetState extends State<MyApiTestingWidget> {
  String accessToken = ''; // Variable pour stocker le token d'accès

  void fetchData() async {
    try {
      var response = await http.get(
        Uri.parse('$apiUrl/api/user/profile/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        //body: {
        // 'email': 'r@r.com',
        //'password': '2017',
        // 'name': 'root',
        //'password2': '2017',
        //},
      );

      print('Fetch Data - Response status: ${response.statusCode}');
      print('Fetch Data - Response body: ${response.body}');
    } catch (e) {
      print('Fetch Data - Error: $e');
    }
  }

  void fetchToken() async {
    try {
      var response = await http.post(
        Uri.parse('$apiUrl/api/user/login/'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': 'r@r.com',
          'password': '2016',
          // 'name': 'root',
          // 'password2': '2016',
        },
      );

      print('Fetch Token - Response status: ${response.statusCode}');
      print('Fetch Token - Response body: ${response.body}');

      // Convertir la réponse JSON en un objet Dart
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // Extraire le token d'accès de la réponse
      String accessToken = jsonResponse['token']['access'];

      // Stocker le token d'accès dans l'état de l'application
      setState(() {
        this.accessToken = accessToken;
      });
    } catch (e) {
      print('Fetch Token - Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing API Calls'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: fetchData,
              child: const Text('Fetch User Data'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchToken,
              child: const Text('Fetch Token'),
            ),
            const SizedBox(height: 20),
            Text('Access Token: $accessToken'),
          ],
        ),
      ),
    );
  }
}
