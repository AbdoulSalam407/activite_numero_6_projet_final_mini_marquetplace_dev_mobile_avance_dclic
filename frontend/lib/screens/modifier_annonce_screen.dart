import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/annonce.dart';
import '../providers/annonce_provider.dart';
import '../widgets/app_colors.dart';
import '../widgets/primary_button.dart';

class ModifierAnnonceScreen extends StatefulWidget {
  const ModifierAnnonceScreen({super.key, required this.annonce});
  final Annonce annonce;

  @override
  State<ModifierAnnonceScreen> createState() => _ModifierAnnonceScreenState();
}

class _ModifierAnnonceScreenState extends State<ModifierAnnonceScreen> {
  late final TextEditingController _titreCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _prixCtrl;
  late final TextEditingController _locCtrl;

  late String _categorie;
  late String _condition;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titreCtrl = TextEditingController(text: widget.annonce.titre);
    _descCtrl = TextEditingController(text: widget.annonce.description);
    _prixCtrl = TextEditingController(text: widget.annonce.prix.toString());
    _locCtrl = TextEditingController(text: widget.annonce.localisation);
    _categorie = widget.annonce.categorie;
    _condition = widget.annonce.condition;
  }

  @override
  void dispose() {
    _titreCtrl.dispose();
    _descCtrl.dispose();
    _prixCtrl.dispose();
    _locCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final prov = context.read<AnnonceProvider>();
    final ok = await prov.update(widget.annonce.id, {
      'titre': _titreCtrl.text.trim(),
      'description': _descCtrl.text.trim(),
      'prix': int.parse(_prixCtrl.text.trim()),
      'localisation': _locCtrl.text.trim(),
      'categorie': _categorie,
      'condition': _condition,
    });

    if (!mounted) return;
    if (ok) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Annonce mise à jour')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(prov.error ?? 'Erreur')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AnnonceProvider>().loading;

    return Scaffold(
      appBar: AppBar(title: const Text('Modifier annonce')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titreCtrl,
                decoration: const InputDecoration(labelText: 'Titre'),
                validator: (v) => v?.isEmpty ?? true ? 'Requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 4,
                validator: (v) => v?.isEmpty ?? true ? 'Requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _prixCtrl,
                decoration: const InputDecoration(labelText: 'Prix (CFA)'),
                keyboardType: TextInputType.number,
                validator: (v) => v?.isEmpty ?? true ? 'Requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locCtrl,
                decoration: const InputDecoration(labelText: 'Localisation'),
                validator: (v) => v?.isEmpty ?? true ? 'Requis' : null,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: loading ? 'Enregistrement...' : 'Enregistrer',
                onPressed: loading ? null : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
