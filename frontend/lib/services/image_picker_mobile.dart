import 'dart:convert';
import 'package:image_picker/image_picker.dart';

Future<String?> pickImageMobile() async {
  final picker = ImagePicker();
  final xfile = await picker.pickImage(
    source: ImageSource.gallery,
    maxWidth: 800,
    imageQuality: 75,
  );
  if (xfile == null) return null;
  final bytes = await xfile.readAsBytes();
  final mime = xfile.mimeType ?? 'image/jpeg';
  return 'data:$mime;base64,${base64Encode(bytes)}';
}

Future<String?> pickImageWeb() async => null;
