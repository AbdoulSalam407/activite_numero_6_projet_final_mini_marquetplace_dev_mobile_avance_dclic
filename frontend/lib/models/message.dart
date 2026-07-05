class Message {
  final String id;
  final String annonceId;
  final String fromId;
  final String toId;
  final String content;
  final bool read;
  final DateTime createdAt;

  const Message({
    required this.id,
    required this.annonceId,
    required this.fromId,
    required this.toId,
    required this.content,
    required this.read,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json['id']?.toString() ?? '',
        annonceId: json['annonceId'] ?? '',
        fromId: json['fromId'] ?? '',
        toId: json['toId'] ?? '',
        content: json['content'] ?? '',
        read: json['read'] ?? false,
        createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'annonceId': annonceId,
        'fromId': fromId,
        'toId': toId,
        'content': content,
        'read': read,
        'createdAt': createdAt.toIso8601String(),
      };
}

class Conversation {
  final String id;
  final String userId;
  final String otherUserId;
  final String otherUserName;
  final String annonceId;
  final String annonceTitle;
  final String lastMessage;
  final int unreadCount;
  final DateTime updatedAt;

  const Conversation({
    required this.id,
    required this.userId,
    required this.otherUserId,
    required this.otherUserName,
    required this.annonceId,
    required this.annonceTitle,
    required this.lastMessage,
    required this.unreadCount,
    required this.updatedAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        id: json['id']?.toString() ?? '',
        userId: json['userId'] ?? '',
        otherUserId: json['otherUserId'] ?? '',
        otherUserName: json['otherUserName'] ?? '',
        annonceId: json['annonceId'] ?? '',
        annonceTitle: json['annonceTitle'] ?? '',
        lastMessage: json['lastMessage'] ?? '',
        unreadCount: json['unreadCount'] ?? 0,
        updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      );
}
