import 'package:flutter/foundation.dart';

// Importe l'implémentation selon la plateforme
import 'image_picker_web.dart' if (dart.library.io) 'image_picker_mobile.dart';

abstract class ImagePickerService {
  static Future<String?> pickImage() {
    if (kIsWeb) {
      return pickImageWeb();
    } else {
      return pickImageMobile();
    }
  }
}
