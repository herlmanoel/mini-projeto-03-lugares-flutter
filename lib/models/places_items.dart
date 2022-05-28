
import 'package:f3_lugares/data/my_data.dart';
import 'package:f3_lugares/models/country.dart';
import 'package:f3_lugares/models/place.dart';
import 'package:flutter/material.dart';

class PlacesItems extends ChangeNotifier {
  List<Place> places = DUMMY_PLACES;
  List<Country> countries = DUMMY_COUNTRIES;

  List<Country> getCountries() {
    return [...countries];
  }
  
  List<Place> getAllPlaces() {
    return places;
  }
  bool placeTitleExists(String id) {
    Place exists = places.firstWhere((place) => place.id == id);
    return true;

    return false;
  }

  addPlace(Place place) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      titulo: place.titulo,
      paises: place.paises,
      imagemUrl: place.imagemUrl,
      recomendacoes: place.recomendacoes,
      avaliacao: place.avaliacao,
      custoMedio: place.custoMedio,
    );
    places.add(newPlace);
    notifyListeners();
  }

  removePlace(String id) {
    places.removeWhere((place) => place.id == id);
    notifyListeners();
  }

  Place findById(String id) {
    return places.firstWhere((place) => place.id == id);
  }

  String getLastId() {
    return places.last.id;
  }

  void setFavorite(String id) {
    final place = findById(id);
    place.setFavorite(!place.isFavorite);
    notifyListeners();
  }

  List<Place> getFavorites() {
    return places.where((place) => place.isFavorite).toList();
  }

  void updateCountry(Country country) {
    final countryIndex = countries.indexWhere((c) => c.id == country.id);
    countries[countryIndex] = country;
    notifyListeners();
  }

  updatePlace(Place place) {
    final placeIndex = places.indexWhere((p) => p.id == place.id);
    places[placeIndex] = place;
    notifyListeners();
  }

  void updateCountrySelected(String id) {
    final country = countries.firstWhere((c) => c.id == id);
    country.isSelected = !country.isSelected;
    // notifyListeners();
  }

  bool placeExists(String id) {
    return places.any((place) => place.id == id);
  }

  List<Place> getPlacesByCountry(String id) {
    return places.where((place) => place.paises.contains(id)).toList();
  }

  void removePlaceById(String id) {
    places.removeWhere((place) => place.id == id);
    notifyListeners();
  }
}