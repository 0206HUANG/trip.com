import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/destination.dart';
import '../services/destinations_service.dart';

class DestinationsProvider extends ChangeNotifier {
  final DestinationsService _service = DestinationsService();
  
  List<Destination> _destinations = [];
  List<String> _favoriteIds = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<Destination> get destinations => _searchQuery.isEmpty
      ? _destinations
      : _destinations
          .where((dest) =>
              dest.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              dest.location.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              dest.category.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();

  List<Destination> get favoriteDestinations => _destinations
      .where((dest) => _favoriteIds.contains(dest.id))
      .toList();

  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  DestinationsProvider() {
    _loadFavorites();
    loadDestinations();
  }

  Future<void> loadDestinations() async {
    _isLoading = true;
    notifyListeners();

    try {
      _destinations = await _service.getDestinations();
    } catch (e) {
      // Handle error
      debugPrint('Error loading destinations: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  bool isFavorite(String destinationId) {
    return _favoriteIds.contains(destinationId);
  }

  Future<void> toggleFavorite(String destinationId) async {
    if (_favoriteIds.contains(destinationId)) {
      _favoriteIds.remove(destinationId);
    } else {
      _favoriteIds.add(destinationId);
    }
    
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteIds = prefs.getStringList('favorite_destinations') ?? [];
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorite_destinations', _favoriteIds);
  }

  Destination? getDestinationById(String id) {
    try {
      return _destinations.firstWhere((dest) => dest.id == id);
    } catch (e) {
      return null;
    }
  }
} 