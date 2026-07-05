class Annonce {
  final String id;
  final String titre;
  final String description;
  final int prix;
  final String image;
  final String categorie;
  final String localisation;
  final String vendeurId;
  final String condition;
  final String status;
  final DateTime createdAt;

  const Annonce({
    required this.id,
    required this.titre,
    required this.description,
    required this.prix,
    required this.image,
    required this.categorie,
    required this.localisation,
    required this.vendeurId,
    required this.condition,
    required this.status,
    required this.createdAt,
  });

  bool get isSold => status == 'sold';
  bool get isActive => status == 'active';

  factory Annonce.fromJson(Map<String, dynamic> json) => Annonce(
        id: json['id']?.toString() ?? '',
        titre: json['titre'] ?? '',
        description: json['description'] ?? '',
        prix: (json['prix'] is int)
            ? json['prix']
            : int.tryParse(json['prix'].toString()) ?? 0,
        image: json['image'] ?? '',
        categorie: json['categorie'] ?? '',
        localisation: json['localisation'] ?? '',
        vendeurId: json['vendeurId'] ?? '',
        condition: json['condition'] ?? '',
        status: json['status'] ?? 'active',
        createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'titre': titre,
        'description': description,
        'prix': prix,
        'image': image,
        'categorie': categorie,
        'localisation': localisation,
        'vendeurId': vendeurId,
        'condition': condition,
        'status': status,
        'createdAt': createdAt.toIso8601String(),
      };

  Annonce copyWith({
    String? titre,
    String? description,
    int? prix,
    String? image,
    String? categorie,
    String? localisation,
    String? condition,
    String? status,
  }) =>
      Annonce(
        id: id,
        titre: titre ?? this.titre,
        description: description ?? this.description,
        prix: prix ?? this.prix,
        image: image ?? this.image,
        categorie: categorie ?? this.categorie,
        localisation: localisation ?? this.localisation,
        vendeurId: vendeurId,
        condition: condition ?? this.condition,
        status: status ?? this.status,
        createdAt: createdAt,
      );
}
