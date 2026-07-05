import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/annonce.dart';
import 'app_colors.dart';

class AnnonceCard extends StatelessWidget {
  const AnnonceCard({super.key, required this.annonce, this.onTap});
  final Annonce annonce;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _image()),
            Padding(
              padding: const EdgeInsets.all(10),
              child: _info(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image() {
    final raw = annonce.image;
    final isBase64 = raw.startsWith('data:image');
    final imageUrl = isBase64 ? raw : _resolveImageUrl(raw);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: isBase64
              ? Image.memory(
                  base64Decode(raw.split(',').last),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _placeholder(),
                )
              : imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: const Color(0xFFF3F4F6),
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      errorWidget: (_, __, ___) => _placeholder(),
                    )
                  : _placeholder(),
        ),
        Positioned(
          left: 8,
          bottom: 8,
          child: _Badge(annonce.condition, Colors.black87),
        ),
        if (annonce.isSold)
          Positioned(
            right: 8,
            top: 8,
            child: _Badge('Vendue', AppColors.error),
          ),
      ],
    );
  }

  Widget _info() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          annonce.titre,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(
          '${annonce.prix} FCFA',
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w900,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            const Icon(Icons.location_on_outlined,
                size: 12, color: AppColors.textSecondary),
            const SizedBox(width: 2),
            Expanded(
              child: Text(
                annonce.localisation,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 11),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _placeholder() => Container(
        color: const Color(0xFFF3F4F6),
        child: const Center(
          child: Icon(Icons.image_outlined,
              size: 40, color: AppColors.textSecondary),
        ),
      );

  /// Passe les URLs non-Unsplash par un proxy CORS
  static String _resolveImageUrl(String url) {
    if (url.isEmpty) return '';
    if (url.contains('unsplash.com')) return url;
    // Proxy weserv.nl supporte le CORS depuis localhost
    return 'https://images.weserv.nl/?url=${Uri.encodeComponent(url)}&w=400&output=webp';
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.text, this.color);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
        ),
      );
}
