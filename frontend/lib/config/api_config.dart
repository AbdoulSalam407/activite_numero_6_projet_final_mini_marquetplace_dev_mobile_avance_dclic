/// Configuration de l'API Backend
///
/// Modifiez ces valeurs selon votre environnement:
/// - Web: Pas de modification nécessaire (utilise localhost)
/// - Émulateur Android: Pas de modification nécessaire (utilise 10.0.2.2)
/// - Appareil physique Android/iOS: Remplacez l'IP locale
///
/// Pour trouver votre IP locale:
/// Windows:  ipconfig
/// macOS/Linux: ifconfig
///
/// Exemple:
/// IP trouvée: 192.168.1.50
/// Mettez: https://192.168.1.50:3001

class ApiConfig {
  /// URL de production Render (laisser null pour utiliser localhost en dev)
  static const String? productionUrl = 'https://mini-marketplace-api.onrender.com';
  // Remplacer par ton URL exacte Render

  /// IP locale pour appareils physiques (ignoré si productionUrl est défini)
  static const String? customIpAddress = null;

  /// Port du backend (local uniquement)
  static const int backendPort = 3001;

  /// URL complète custom
  static String get customBaseUrl {
    if (productionUrl != null) return productionUrl!;
    if (customIpAddress == null) return '';
    return 'http://$customIpAddress:$backendPort';
  }
}
