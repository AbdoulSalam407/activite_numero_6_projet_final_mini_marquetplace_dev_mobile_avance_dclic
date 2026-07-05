import 'dart:math';
import '../models/message.dart';
import 'api_service.dart';

class MessageService {
  static Future<List<Conversation>> getConversations(String userId) async {
    final data = await ApiService.get('/conversations?userId=$userId') as List;
    return data.map((e) => Conversation.fromJson(e)).toList();
  }

  static Future<List<Message>> getMessages(String annonceId) async {
    final data = await ApiService.get('/messages?annonceId=$annonceId') as List;
    return data.map((e) => Message.fromJson(e)).toList();
  }

  static Future<Message> send(Map<String, dynamic> body) async {
    body['id'] = 'm${Random().nextInt(99999)}';
    body['read'] = false;
    body['createdAt'] = DateTime.now().toIso8601String();
    final data = await ApiService.post('/messages', body);
    return Message.fromJson(data);
  }

  static Future<void> markRead(String id) =>
      ApiService.patch('/messages/$id', {'read': true});

  /// Crée ou met à jour les deux entrées de conversation (buyer + seller)
  static Future<void> upsertConversation({
    required String buyerId,
    required String sellerId,
    required String sellerName,
    required String buyerName,
    required String annonceId,
    required String annonceTitle,
    required String lastMessage,
  }) async {
    final now = DateTime.now().toIso8601String();

    // Vérifie si la conversation existe déjà pour le buyer
    final existing = await ApiService.get(
      '/conversations?userId=$buyerId&annonceId=$annonceId',
    ) as List;

    if (existing.isEmpty) {
      // Crée la conv côté buyer
      final rnd = Random().nextInt(99999);
      await ApiService.post('/conversations', {
        'id': 'conv$rnd',
        'userId': buyerId,
        'otherUserId': sellerId,
        'otherUserName': sellerName,
        'annonceId': annonceId,
        'annonceTitle': annonceTitle,
        'lastMessage': lastMessage,
        'unreadCount': 0,
        'updatedAt': now,
      });
      // Crée la conv côté seller
      await ApiService.post('/conversations', {
        'id': 'conv${rnd + 1}',
        'userId': sellerId,
        'otherUserId': buyerId,
        'otherUserName': buyerName,
        'annonceId': annonceId,
        'annonceTitle': annonceTitle,
        'lastMessage': lastMessage,
        'unreadCount': 1,
        'updatedAt': now,
      });
    } else {
      // Met à jour les deux convs existantes
      final buyerConv = existing.first;
      await ApiService.patch('/conversations/${buyerConv['id']}', {
        'lastMessage': lastMessage,
        'updatedAt': now,
      });
      final sellerConvs = await ApiService.get(
        '/conversations?userId=$sellerId&annonceId=$annonceId',
      ) as List;
      if (sellerConvs.isNotEmpty) {
        final sellerConv = sellerConvs.first;
        await ApiService.patch('/conversations/${sellerConv['id']}', {
          'lastMessage': lastMessage,
          'unreadCount': (sellerConv['unreadCount'] ?? 0) + 1,
          'updatedAt': now,
        });
      }
    }
  }
}
