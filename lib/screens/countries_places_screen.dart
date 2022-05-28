import 'package:f3_lugares/components/place_item.dart';
import 'package:f3_lugares/models/country.dart';
import 'package:f3_lugares/models/places_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryPlacesScreen extends StatelessWidget {
  //Country country;
  // CountryPlacesScreen(this.country);

  @override
  Widget build(BuildContext context) {
    final country = ModalRoute.of(context)!.settings.arguments as Country;
    final provider = Provider.of<PlacesItems>(context, listen: false);
    final countryPlaces = provider.places.where((places) {
      return places.paises.contains(country.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(country.title),
      ),
      body: Consumer<PlacesItems>(
        builder: (context, value, child) { 
          return ListView.builder(
            itemCount: value.getPlacesByCountry(country.id).length,
            itemBuilder: (ctx, index) {
              return PlaceItem(value.getPlacesByCountry(country.id)[index]);
            });
        },
      ),
    );
  }
}
