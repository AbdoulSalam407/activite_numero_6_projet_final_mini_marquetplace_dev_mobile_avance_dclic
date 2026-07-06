import 'dart:async';
import 'dart:html' as html;

Future<String?> pickImageWeb() async {
  final completer = Completer<String?>();
  final input = html.FileUploadInputElement()..accept = 'image/*';

  input.onChange.listen((_) {
    final file = input.files?.first;
    if (file == null) {
      completer.complete(null);
      return;
    }
    final reader = html.FileReader();
    reader.readAsDataUrl(file);
    reader.onLoad.listen((_) => completer.complete(reader.result as String));
    reader.onError.listen((_) => completer.complete(null));
  });

  input.click();

  // Timeout si l'utilisateur ferme sans choisir
  Future.delayed(const Duration(minutes: 2), () {
    if (!completer.isCompleted) completer.complete(null);
  });

  return completer.future;
}

Future<String?> pickImageMobile() async => null;
