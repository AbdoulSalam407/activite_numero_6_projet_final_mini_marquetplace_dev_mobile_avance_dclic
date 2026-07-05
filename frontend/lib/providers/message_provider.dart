import 'package:flutter/foundation.dart';
import '../models/message.dart';
import '../services/message_service.dart';

class MessageProvider extends ChangeNotifier {
  List<Conversation> _conversations = [];
  List<Message> _messages = [];
  bool _loading = false;

  List<Conversation> get conversations => _conversations;
  List<Message> get messages => _messages;
  bool get loading => _loading;
  int get unreadTotal =>
      _conversations.fold(0, (sum, c) => sum + c.unreadCount);

  Future<void> fetchConversations(String userId) async {
    _loading = true;
    notifyListeners();
    try {
      _conversations = await MessageService.getConversations(userId);
    } catch (_) {
      _conversations = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMessages(String annonceId) async {
    _loading = true;
    notifyListeners();
    try {
      _messages = await MessageService.getMessages(annonceId);
    } catch (_) {
      _messages = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> send(Map<String, dynamic> body) async {
    try {
      final msg = await MessageService.send(body);
      _messages.add(msg);
      notifyListeners();
      return true;
    } catch (_) {
      return false;
    }
  }
}
