import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/annonce_provider.dart';
import '../widgets/annonce_card.dart';
import '../widgets/app_colors.dart';
import 'annonce_detail_screen.dart';

const _categories = [
  {'id': 'c1', 'label': 'Electronique', 'icon': Icons.phone_android},
  {'id': 'c2', 'label': 'Mode', 'icon': Icons.checkroom},
  {'id': 'c3', 'label': 'Maison', 'icon': Icons.home},
  {'id': 'c4', 'label': 'Services', 'icon': Icons.work_outline},
  {'id': 'c5', 'label': 'Véhicules', 'icon': Icons.directions_car},
];

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catégories')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final cat = _categories[i];
          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => _CategoryProducts(
                  id: cat['id'] as String,
                  label: cat['label'] as String,
                ),
              ),
            ),
            borderRadius: BorderRadius.circular(12),
            child: Ink(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(.1),
                    child: Icon(cat['icon'] as IconData,
                        color: AppColors.primary),
                  ),
                  const SizedBox(width: 16),
                  Text(cat['label'] as String,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                  const Spacer(),
                  const Icon(Icons.chevron_right,
                      color: AppColors.textSecondary),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryProducts extends StatefulWidget {
  const _CategoryProducts({required this.id, required this.label});
  final String id;
  final String label;

  @override
  State<_CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<_CategoryProducts> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<AnnonceProvider>().setCategory(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<AnnonceProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(widget.label)),
      body: prov.loading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary))
          : prov.annonces.isEmpty
              ? const Center(
                  child: Text('Aucune annonce dans cette catégorie'))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: prov.annonces.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
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
                          builder: (_) =>
                              AnnonceDetailScreen(annonceId: a.id),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
