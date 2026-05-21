import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _userEmail = '';
  String _userName = '';
  String _userPhone = '';
  String _userProfileImage = '';

  bool get isLoggedIn => _isLoggedIn;
  String get userEmail => _userEmail;
  String get userName => _userName;
  String get userPhone => _userPhone;
  String get userProfileImage => _userProfileImage;

  AuthProvider() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userEmail = prefs.getString('userEmail') ?? '';
    _userName = prefs.getString('userName') ?? '';
    _userPhone = prefs.getString('userPhone') ?? '';
    _userProfileImage = prefs.getString('userProfileImage') ?? '';
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _isLoggedIn = true;
    _userEmail = email;
    _userName = email.split('@').first;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email);
    await prefs.setString('userName', _userName);
    notifyListeners();
  }

  Future<void> signup(String name, String email, String password) async {
    _isLoggedIn = true;
    _userName = name;
    _userEmail = email;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', email);
    await prefs.setString('userName', name);
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _userEmail = '';
    _userName = '';
    _userPhone = '';
    _userProfileImage = '';

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userEmail');
    await prefs.remove('userName');
    notifyListeners();
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    String? profileImage,
  }) async {
    _userName = name;
    _userPhone = phone;
    if (profileImage != null) {
      _userProfileImage = profileImage;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    await prefs.setString('userPhone', phone);
    if (profileImage != null) {
      await prefs.setString('userProfileImage', profileImage);
    }
    notifyListeners();
  }
}