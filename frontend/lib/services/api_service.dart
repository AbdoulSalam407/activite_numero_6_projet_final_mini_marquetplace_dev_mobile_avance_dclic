import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, {this.statusCode});
  @override
  String toString() => message;
}

class ApiService {
  /// Configuration automatique selon la plateforme:
  /// - Web (Chrome, Firefox, etc.) → localhost:3001
  /// - Android Emulator → 10.0.2.2:3001
  /// - Android Device → utilise customIpAddress si défini, sinon 10.0.2.2:3001
  /// - iOS Simulator → localhost:3001
  /// - iOS Device → utilise customIpAddress si défini, sinon localhost:3001
  ///
  /// Pour configurer une IP personnalisée, éditez: lib/config/api_config.dart
  static String get baseUrl {
    // URL de production Render en priorité
    if (ApiConfig.productionUrl != null) {
      return ApiConfig.productionUrl!;
    }
    if (ApiConfig.customIpAddress != null) {
      return ApiConfig.customBaseUrl;
    }
    if (kIsWeb) {
      return 'http://localhost:3001';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:3001'; // émulateur uniquement
    } else if (Platform.isIOS) {
      return 'http://localhost:3001';
    }
    return 'http://localhost:3001';
  }

  static Future<dynamic> get(String endpoint) async {
    final res = await http
        .get(Uri.parse('$baseUrl$endpoint'))
        .timeout(const Duration(seconds: 60));
    return _handle(res);
  }

  static Future<dynamic> post(
      String endpoint, Map<String, dynamic> body) async {
    final res = await http
        .post(
          Uri.parse('$baseUrl$endpoint'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 60));
    return _handle(res);
  }

  static Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final res = await http
        .put(
          Uri.parse('$baseUrl$endpoint'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 60));
    return _handle(res);
  }

  static Future<dynamic> patch(
      String endpoint, Map<String, dynamic> body) async {
    final res = await http
        .patch(
          Uri.parse('$baseUrl$endpoint'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 60));
    return _handle(res);
  }

  static Future<void> delete(String endpoint) async {
    final res = await http
        .delete(Uri.parse('$baseUrl$endpoint'))
        .timeout(const Duration(seconds: 60));
    _handle(res);
  }

  static dynamic _handle(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (res.body.isEmpty) return null;
      return jsonDecode(res.body);
    }
    throw ApiException('Erreur ${res.statusCode}: ${res.reasonPhrase}',
        statusCode: res.statusCode);
  }
}
