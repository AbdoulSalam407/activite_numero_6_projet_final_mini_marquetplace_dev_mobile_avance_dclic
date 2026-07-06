import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/annonce_provider.dart';
import '../services/image_picker_service.dart';
import '../widgets/app_colors.dart';
import '../widgets/primary_button.dart';

class CreateAnnonceScreen extends StatefulWidget {
  const CreateAnnonceScreen({super.key});

  @override
  State<CreateAnnonceScreen> createState() => _CreateAnnonceScreenState();
}

class _CreateAnnonceScreenState extends State<CreateAnnonceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titreCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _prixCtrl = TextEditingController();
  final _locCtrl = TextEditingController();
  final _imageUrlCtrl = TextEditingController();

  String _categorie = 'c1';
  String _condition = 'Neuf';
  String? _imageBase64; // image choisie depuis l'appareil
  bool _pickingImage = false;

  final _categories = {
    'c1': 'Electronique',
    'c2': 'Mode',
    'c3': 'Maison',
    'c4': 'Services',
    'c5': 'Véhicules',
  };

  final _conditions = ['Neuf', 'Très bon état', 'Bon état', 'Occasion'];

  @override
  void dispose() {
    _titreCtrl.dispose();
    _descCtrl.dispose();
    _prixCtrl.dispose();
    _locCtrl.dispose();
    _imageUrlCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    setState(() => _pickingImage = true);
    try {
      final result = await ImagePickerService.pickImage();
      if (result != null) {
        setState(() => _imageBase64 = result);
      }
    } finally {
      setState(() => _pickingImage = false);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final user = context.read<AuthProvider>().user;
    if (user == null) return;

    final prov = context.read<AnnonceProvider>();
    final imageValue = _imageBase64 ??
        (_imageUrlCtrl.text.trim().isNotEmpty
            ? _imageUrlCtrl.text.trim()
            : 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800');
    final ok = await prov.create({
      'titre': _titreCtrl.text.trim(),
      'description': _descCtrl.text.trim(),
      'prix': int.parse(_prixCtrl.text.trim()),
      'localisation': _locCtrl.text.trim(),
      'image': imageValue,
      'categorie': _categorie,
      'condition': _condition,
      'vendeurId': user.id,
      'status': 'active',
    });

    if (!mounted) return;
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Annonce créée avec succès !')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(prov.error ?? 'Erreur')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AnnonceProvider>().loading;

    return Scaffold(
      appBar: AppBar(title: const Text('Créer une annonce')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titreCtrl,
                decoration: const InputDecoration(
                  labelText: 'Titre de l\'annonce',
                  hintText: 'Ex: iPhone 13 Pro Max',
                ),
                validator: (v) => (v ?? '').isEmpty ? 'Requis' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _categorie,
                decoration: const InputDecoration(labelText: 'Catégorie'),
                items: _categories.entries
                    .map((e) => DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _categorie = v ?? 'c1'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _condition,
                decoration: const InputDecoration(labelText: 'Condition'),
                items: _conditions
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _condition = v ?? 'Neuf'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Décrivez votre produit...',
                ),
                maxLines: 4,
                validator: (v) => (v ?? '').isEmpty ? 'Requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _prixCtrl,
                decoration: const InputDecoration(
                  labelText: 'Prix (CFA)',
                  hintText: 'Ex: 100000',
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if ((v ?? '').isEmpty) return 'Requis';
                  if (int.tryParse(v ?? '') == null) return 'Nombre invalide';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locCtrl,
                decoration: const InputDecoration(
                  labelText: 'Localisation',
                  hintText: 'Ex: Dakar - Plateau',
                ),
                validator: (v) => (v ?? '').isEmpty ? 'Requis' : null,
              ),
              const SizedBox(height: 16),
              _ImagePicker(
                imageBase64: _imageBase64,
                isLoading: _pickingImage,
                onPick: _pickImage,
                onRemove: () => setState(() => _imageBase64 = null),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: loading ? 'Création...' : 'Créer l\'annonce',
                onPressed: loading ? null : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImagePicker extends StatelessWidget {
  const _ImagePicker({
    required this.imageBase64,
    required this.isLoading,
    required this.onPick,
    required this.onRemove,
  });

  final String? imageBase64;
  final bool isLoading;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    if (imageBase64 != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(
              base64Decode(imageBase64!.split(',').last),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      );
    }

    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPick,
      icon: isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.photo_library_outlined),
      label: Text(isLoading ? 'Chargement...' : 'Choisir une image'),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        side: const BorderSide(color: AppColors.primary),
        foregroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
