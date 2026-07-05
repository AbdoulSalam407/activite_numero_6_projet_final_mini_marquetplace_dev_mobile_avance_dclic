import 'dart:math';
import '../models/user.dart';
import 'api_service.dart';

class AuthService {
  /// JSON Server ne gère pas les mots de passe.
  /// On vérifie juste que l'email existe — suffisant pour la démo.
  static Future<User?> login(String email) async {
    final data = await ApiService.get('/users?email=$email') as List;
    if (data.isEmpty) return null;
    return User.fromJson(data.first);
  }

  static Future<User> register(Map<String, dynamic> body) async {
    final existing = await ApiService.get('/users?email=${body['email']}') as List;
    if (existing.isNotEmpty) throw ApiException('Cet email est déjà utilisé.');
    body['id'] = 'u${Random().nextInt(99999)}';
    body['avatar'] = '';
    body['role'] = 'buyer';
    final data = await ApiService.post('/users', body);
    return User.fromJson(data);
  }

  static Future<User> updateProfile(String id, Map<String, dynamic> body) async {
    final data = await ApiService.put('/users/$id', body);
    return User.fromJson(data);
  }
}
