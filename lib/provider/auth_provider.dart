import 'package:djikarice_delivery/helpers/database_helper.dart';
import 'package:djikarice_delivery/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:djikarice_delivery/utils.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  bool _isAuthenticated = false;
  User? _user;

  String? get token => _token;
  bool get isAuthenticated => _isAuthenticated;
  User? get user => _user;
  AuthProvider() {
    _loadToken();
  }

  Future<void> _loadToken() async {
    _token = await DatabaseHelper().getToken();
    if (_token != null) {
      _isAuthenticated = true;
    }
    notifyListeners();
  }

  Future<void> _saveToken(String token) async {
    await DatabaseHelper().saveToken(token);
  }

  Future<void> _removeToken() async {
    await DatabaseHelper().deleteToken();
  }

  Future<void> loadUserInformation() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/user/profile/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        print(jsonResponse["user"]);


        _isAuthenticated = true;
        notifyListeners();
      } else {
        throw Exception('Failed to load user information');
      }
    } catch (e) {
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
      _isAuthenticated = true;
      await _saveToken(_token!);
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

    if (response.statusCode == 200) {
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
