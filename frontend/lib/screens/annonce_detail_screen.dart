import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/annonce.dart';
import '../providers/auth_provider.dart';
import '../providers/annonce_provider.dart';
import '../providers/message_provider.dart';
import '../services/annonce_service.dart';
import '../services/message_service.dart';
import '../services/api_service.dart';
import '../widgets/app_colors.dart';
import '../widgets/primary_button.dart';
import 'modifier_annonce_screen.dart';
import 'shell_screen.dart';

class AnnonceDetailScreen extends StatefulWidget {
  const AnnonceDetailScreen({super.key, required this.annonceId});
  final String annonceId;

  @override
  State<AnnonceDetailScreen> createState() => _AnnonceDetailScreenState();
}

class _AnnonceDetailScreenState extends State<AnnonceDetailScreen> {
  Annonce? _annonce;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final a = await AnnonceService.getById(widget.annonceId);
      setState(() {
        _annonce = a;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _contactVendeur(Annonce ann, String buyerId) async {
    final msgCtrl = TextEditingController(
      text: 'Bonjour, est-ce que "${ann.titre}" est toujours disponible ?',
    );
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Contacter le vendeur'),
        content: TextField(
          controller: msgCtrl,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Votre message...',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Envoyer'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    final content = msgCtrl.text.trim();
    if (content.isEmpty) return;

    // Récupère le nom du buyer et du seller
    final user = context.read<AuthProvider>().user!;
    final buyerName = '${user.firstName} ${user.lastName}';

    String sellerName = ann.vendeurId;
    try {
      final sellerData =
          await ApiService.get('/users/${ann.vendeurId}') as Map<String, dynamic>;
      sellerName =
          '${sellerData['firstName'] ?? ''} ${sellerData['lastName'] ?? ''}'.trim();
    } catch (_) {}

    // Envoie le message
    final ok = await context.read<MessageProvider>().send({
      'annonceId': ann.id,
      'fromId': buyerId,
      'toId': ann.vendeurId,
      'content': content,
    });

    if (!ok || !mounted) return;

    // Crée ou met à jour les conversations
    await MessageService.upsertConversation(
      buyerId: buyerId,
      sellerId: ann.vendeurId,
      sellerName: sellerName,
      buyerName: buyerName,
      annonceId: ann.id,
      annonceTitle: ann.titre,
      lastMessage: content,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Message envoyé !')),
    );

    // Navigue vers l'onglet Messages
    Navigator.pop(context);
    ShellScreen.jumpToTab(context, 2);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null || _annonce == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text('Erreur: $_error'),
        ),
      );
    }

    final ann = _annonce!;
    final user = context.watch<AuthProvider>().user;
    final isOwner = user?.id == ann.vendeurId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails'),
        actions: [
          if (isOwner)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ModifierAnnonceScreen(annonce: ann),
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (ann.image.isNotEmpty)
              ann.image.startsWith('data:image')
                  ? Image.memory(
                      base64Decode(ann.image.split(',').last),
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: double.infinity,
                        height: 300,
                        color: AppColors.border,
                        child: const Icon(Icons.image_not_supported),
                      ),
                    )
                  : Image.network(
                      _resolveImageUrl(ann.image),
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: double.infinity,
                        height: 300,
                        color: AppColors.border,
                        child: const Icon(Icons.image_not_supported),
                      ),
                    ),
            // Contenu
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          ann.titre,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (ann.isSold)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Vendue',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${ann.prix.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')} CFA',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfo('Condition', ann.condition),
                  _buildInfo('Localisation', ann.localisation),
                  const SizedBox(height: 16),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(ann.description),
                  const SizedBox(height: 32),
                  if (!isOwner && ann.isActive)
                    PrimaryButton(
                      label: 'Contacter le vendeur',
                      onPressed: () => _contactVendeur(ann, user!.id),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _resolveImageUrl(String url) {
    if (url.isEmpty) return '';
    if (url.contains('unsplash.com')) return url;
    return 'https://images.weserv.nl/?url=${Uri.encodeComponent(url)}&w=800&output=webp';
  }

  Widget _buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
