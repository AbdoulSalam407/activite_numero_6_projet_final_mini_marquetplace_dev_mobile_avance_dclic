import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _loading = false;
  String? _error;

  User? get user => _user;
  bool get loading => _loading;
  String? get error => _error;
  bool get isLoggedIn => _user != null;

  Future<void> restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userId');
    if (id == null) return;
    _user = User(
      id: id,
      firstName: prefs.getString('userFirstName') ?? '',
      lastName: prefs.getString('userLastName') ?? '',
      email: prefs.getString('userEmail') ?? '',
      phone: prefs.getString('userPhone') ?? '',
      role: prefs.getString('userRole') ?? 'buyer',
    );
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      final user = await AuthService.login(email);
      if (user == null) {
        _error = 'Email ou mot de passe incorrect.';
        return false;
      }
      _user = user;
      await _save(user);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> register(Map<String, dynamic> body) async {
    _setLoading(true);
    try {
      final user = await AuthService.register(body);
      _user = user;
      await _save(user);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void _setLoading(bool v) {
    _loading = v;
    if (v) _error = null;
    notifyListeners();
  }

  Future<void> _save(User u) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', u.id);
    await prefs.setString('userFirstName', u.firstName);
    await prefs.setString('userLastName', u.lastName);
    await prefs.setString('userEmail', u.email);
    await prefs.setString('userPhone', u.phone);
    await prefs.setString('userRole', u.role);
  }
}
