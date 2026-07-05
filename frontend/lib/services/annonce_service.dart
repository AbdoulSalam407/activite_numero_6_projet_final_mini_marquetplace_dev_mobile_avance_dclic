import '../models/annonce.dart';
import 'api_service.dart';

class AnnonceService {
  static Future<List<Annonce>> getAll({String? categorie, String? search}) async {
    var endpoint = '/annonces';
    final params = <String>[];
    if (categorie != null && categorie.isNotEmpty) params.add('categorie=$categorie');
    if (search != null && search.isNotEmpty) params.add('titre_like=$search');
    if (params.isNotEmpty) endpoint += '?${params.join('&')}';
    final data = await ApiService.get(endpoint) as List;
    return data.map((e) => Annonce.fromJson(e)).toList();
  }

  static Future<Annonce> getById(String id) async {
    final data = await ApiService.get('/annonces/$id');
    return Annonce.fromJson(data);
  }

  static Future<List<Annonce>> getByVendeur(String vendeurId) async {
    final data = await ApiService.get('/annonces?vendeurId=$vendeurId') as List;
    return data.map((e) => Annonce.fromJson(e)).toList();
  }

  static Future<Annonce> create(Map<String, dynamic> body) async {
    final data = await ApiService.post('/annonces', body);
    return Annonce.fromJson(data);
  }

  static Future<Annonce> update(String id, Map<String, dynamic> body) async {
    final data = await ApiService.put('/annonces/$id', body);
    return Annonce.fromJson(data);
  }

  static Future<void> delete(String id) => ApiService.delete('/annonces/$id');
}
