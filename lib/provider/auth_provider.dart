import 'package:djikarice_delivery/helpers/database_helper.dart';
import 'package:djikarice_delivery/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:djikarice_delivery/utils.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider() {
    _loadToken();
  }
  String? _token;
  String? _refreshToken;
  bool _isAuthenticated = false;
  User? _user;
  Client? _client;
  Livreur? _livreur;
  Responsable? _responsable;

  String? get token => _token;
  String? get refreshtoken => _refreshToken;
  bool get isAuthenticated => _isAuthenticated;
  User? get user => _user;
  Client? get client => _client;
  Livreur? get livreur => _livreur;
  Responsable? get responsable => _responsable;

  Future<void> _loadToken() async {
    _token = await DatabaseHelper().getToken();
    print(_token);
    if (_token != null) {
      _isAuthenticated = true;
      print(_isAuthenticated);
    }
    notifyListeners();
  }

  // fonction pour recupere le refreshtoken
  Future<void> _loadRefreshToken() async {
    _refreshToken = await DatabaseHelper().getRefreshToken();
    print(_refreshToken);
    notifyListeners();
  }

  Future<void> _saveToken(String token, String refreshToken) async {
    await DatabaseHelper().saveToken(token, refreshToken);
  }

  Future<void> _removeToken() async {
    await DatabaseHelper().deleteToken();
  }

  // Fonction pour rafraîchir le token
  Future<void> refreshToken() async {
    _refreshToken = await DatabaseHelper().getRefreshToken();
    final url = Uri.parse('$apiUrl/api/user/token/refresh/');
    final response = await http.post(url, body: {
      'refresh': _refreshToken,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      _token = data['access'];
      await _saveToken(_token!, _refreshToken!);
      notifyListeners();
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  Future<void> loadUserInformation() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/user/profile2/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);

        final userJson = jsonResponse["user"];
        print(userJson);
        _user = User.fromJson(userJson);
        print(_user?.isClient);

        if (_user!.isClient) {
          _client = Client.fromJson(jsonResponse["profile"]);
        } else if (_user!.isLivreur) {
          print(jsonResponse["profile"]);
          _livreur = Livreur.fromJson(jsonResponse["profile"]);
        }

        print(_user?.name);
        _isAuthenticated = true;
        notifyListeners();
      } else {
        throw Exception('Failed to load user information');
      }
    } catch (e) {
      print(e);
      throw Exception('Error loading user information: $e');
    }
  }

Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/api/user/login/'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      _token = jsonResponse['token']['access'];
      _refreshToken = jsonResponse['token']['refresh'];
      _isAuthenticated = true;
      await _saveToken(_token!, _refreshToken!);
      notifyListeners();
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> register(String email, String password, String name,
      String phoneNumber, String role) async {
    final response = await http.post(
      Uri.parse('$apiUrl/api/user/c_register/'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'email': email,
        'password': password,
        'password2': password,
        'name': name,
        'phone_number': phoneNumber,
      },
    );

    if (response.statusCode == 201) {
      await login(email, password);
    } else {
      throw Exception('Failed to register');
    }
  }

  void logout() async {
    _token = null;
    _isAuthenticated = false;
    await _removeToken();
    notifyListeners();
  }
}
