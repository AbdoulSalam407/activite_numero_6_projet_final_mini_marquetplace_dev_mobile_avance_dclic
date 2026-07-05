import 'package:flutter/foundation.dart';
import '../models/annonce.dart';
import '../services/annonce_service.dart';

class AnnonceProvider extends ChangeNotifier {
  List<Annonce> _annonces = [];
  List<Annonce> _myAnnonces = [];
  bool _loading = false;
  String? _error;
  String _search = '';
  String _category = '';

  List<Annonce> get annonces => _annonces;
  List<Annonce> get myAnnonces => _myAnnonces;
  bool get loading => _loading;
  String? get error => _error;
  String get search => _search;
  String get category => _category;

  Future<void> fetchAll() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _annonces = await AnnonceService.getAll(
        categorie: _category.isNotEmpty ? _category : null,
        search: _search.isNotEmpty ? _search : null,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMyAnnonces(String vendeurId) async {
    _loading = true;
    notifyListeners();
    try {
      _myAnnonces = await AnnonceService.getByVendeur(vendeurId);
    } catch (_) {
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> create(Map<String, dynamic> body) async {
    _loading = true;
    notifyListeners();
    try {
      final a = await AnnonceService.create(body);
      _annonces.insert(0, a);
      _myAnnonces.insert(0, a);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> update(String id, Map<String, dynamic> body) async {
    _loading = true;
    notifyListeners();
    try {
      final updated = await AnnonceService.update(id, body);
      _replace(_annonces, id, updated);
      _replace(_myAnnonces, id, updated);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> delete(String id) async {
    try {
      await AnnonceService.delete(id);
      _annonces.removeWhere((a) => a.id == id);
      _myAnnonces.removeWhere((a) => a.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  void setSearch(String v) {
    _search = v;
    fetchAll();
  }

  void setCategory(String v) {
    _category = v;
    fetchAll();
  }

  void _replace(List<Annonce> list, String id, Annonce updated) {
    final i = list.indexWhere((a) => a.id == id);
    if (i != -1) list[i] = updated;
  }
}
