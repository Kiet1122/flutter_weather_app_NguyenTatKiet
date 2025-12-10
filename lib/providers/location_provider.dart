import 'package:flutter/material.dart';
import '../models/location_model.dart';
import '../services/storage_service.dart';
import '../services/location_service.dart';

enum LocationState { initial, loading, loaded, error }

class LocationProvider extends ChangeNotifier {
  final LocationService _locationService;
  final StorageService _storageService;

  LocationModel? _currentLocation;
  LocationState _state = LocationState.initial;
  String _errorMessage = '';

  List<String> _favoriteCities = []; 
  final List<String> _recentSearches = []; 

  LocationProvider(this._locationService, this._storageService) {
    loadFavoriteCities();
  }

  LocationModel? get currentLocation => _currentLocation;
  LocationState get state => _state;
  String get errorMessage => _errorMessage;
  List<String> get favoriteCities => _favoriteCities;
  List<String> get recentSearches => _recentSearches;

  Future<void> fetchCurrentLocation() async {
    _state = LocationState.loading;
    notifyListeners();

    try {
      final position = await _locationService.getCurrentLocation();
      final lat = position.latitude;
      final lon = position.longitude;

      final cityName = await _locationService.getCityName(lat, lon); 

      _currentLocation = LocationModel(
        latitude: lat,
        longitude: lon,
        cityName: cityName,
        country: null, 
      );
      
      _state = LocationState.loaded;
      _errorMessage = '';
    } catch (e) {
      _state = LocationState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> loadFavoriteCities() async {
    _favoriteCities = await _storageService.getFavoriteCities();
    notifyListeners();
  }

  Future<void> addFavoriteCity(String cityName) async {
    if (!_favoriteCities.contains(cityName)) {
      _favoriteCities.add(cityName);
      if (_favoriteCities.length > 5) { 
        _favoriteCities.removeAt(0); 
      }
      await _storageService.saveFavoriteCities(_favoriteCities);
      notifyListeners();
    }
  }

  Future<void> removeFavoriteCity(String cityName) async {
    _favoriteCities.remove(cityName);
    await _storageService.saveFavoriteCities(_favoriteCities);
    notifyListeners();
  }

  void addRecentSearch(String cityName) {
    _recentSearches.remove(cityName); 
    _recentSearches.insert(0, cityName);

    if (_recentSearches.length > 10) { 
      _recentSearches.removeLast();
    }

    notifyListeners();
  }
}