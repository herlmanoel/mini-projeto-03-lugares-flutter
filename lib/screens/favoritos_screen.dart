import 'package:f3_lugares/components/place_item.dart';
import 'package:f3_lugares/models/places_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final provider = Provider.of<PlacesItems>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
      ),
      body: ListView.builder(
          itemCount: provider.getFavorites().length,
          itemBuilder: (ctx, index) {
            return PlaceItem(provider.getFavorites()[index]);
          }),
    );
  }
}
