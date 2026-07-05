import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/annonce_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/annonce_card.dart';
import '../widgets/app_colors.dart';
import 'annonce_detail_screen.dart';
import 'create_annonce_screen.dart';

const _cats = <String, String>{
  '': 'Tous',
  'c1': 'Electronique',
  'c2': 'Mode',
  'c3': 'Maison',
  'c4': 'Services',
  'c5': 'Véhicules',
};

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<AnnonceProvider>().fetchAll());
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<AnnonceProvider>();
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text.rich(TextSpan(
          text: 'MINI ',
          style: TextStyle(fontWeight: FontWeight.w900),
          children: [
            TextSpan(
                text: 'MARKETPLACE',
                style: TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.w900))
          ],
        )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Cherchez un produit…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchCtrl.clear();
                          setState(() {});
                          prov.setSearch('');
                        })
                    : IconButton(
                        icon: const Icon(Icons.tune),
                        onPressed: () => _showFilters(context, prov)),
              ),
              onChanged: (v) {
                setState(() {});
                prov.setSearch(v);
              },
            ),
          ),
          const SizedBox(height: 12),
          _categoryChips(prov),
          const SizedBox(height: 8),
          Expanded(child: _body(prov)),
        ],
      ),
      floatingActionButton: user?.role == 'seller'
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateAnnonceScreen(),
                ),
              ),
              label: const Text('Créer annonce'),
              icon: const Icon(Icons.add),
              backgroundColor: AppColors.primary,
            )
          : null,
    );
  }

  Widget _categoryChips(AnnonceProvider prov) {
    return SizedBox(
      height: 38,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        children: _cats.entries.map((e) {
          final selected = prov.category == e.key;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => prov.setCategory(e.key),
              child: Chip(
                backgroundColor: selected ? AppColors.primary : Colors.white,
                side: BorderSide(
                    color: selected ? AppColors.primary : AppColors.border),
                label: Text(e.value,
                    style: TextStyle(
                        color:
                            selected ? Colors.white : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.symmetric(horizontal: 4),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _body(AnnonceProvider prov) {
    if (prov.loading) {
      return const Center(
          child: CircularProgressIndicator(color: AppColors.primary));
    }
    if (prov.error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off,
                size: 64, color: AppColors.textSecondary),
            const SizedBox(height: 12),
            const Text('Backend inaccessible',
                style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('Vérifiez que JSON Server tourne sur le port 3001',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: prov.fetchAll,
              child: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }
    if (prov.annonces.isEmpty) {
      return const Center(
          child: Text('Aucune annonce',
              style: TextStyle(color: AppColors.textSecondary)));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: prov.annonces.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .65,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (_, i) {
        final a = prov.annonces[i];
        return AnnonceCard(
          annonce: a,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AnnonceDetailScreen(annonceId: a.id)),
          ),
        );
      },
    );
  }

  void _showFilters(BuildContext context, AnnonceProvider prov) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filtres',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: prov.category.isNotEmpty ? prov.category : null,
              hint: const Text('Toutes les catégories'),
              items: _cats.entries
                  .skip(1)
                  .map((e) =>
                      DropdownMenuItem(value: e.key, child: Text(e.value)))
                  .toList(),
              onChanged: (v) => prov.setCategory(v ?? ''),
              decoration: const InputDecoration(labelText: 'Catégorie'),
            ),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size.fromHeight(48)),
              onPressed: () => Navigator.pop(context),
              child: const Text('Appliquer'),
            ),
          ],
        ),
      ),
    );
  }
}
