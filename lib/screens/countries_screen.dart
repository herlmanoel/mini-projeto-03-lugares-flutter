import 'package:f3_lugares/components/country_item.dart';
import 'package:f3_lugares/models/places_items.dart';
import 'package:flutter/material.dart';
import '../data/my_data.dart';

 import 'package:provider/provider.dart'; 
 
class CountriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlacesItems>(context);
    return Container(
      child: GridView(
        padding: const EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent:
              200, //cada elemento com extenso maxima de 200 pixel
          childAspectRatio: 3 / 2, //proporcao de cada elemento dentro do grid
          crossAxisSpacing: 20, //espacamento no eixo cruzado
          mainAxisSpacing: 20, //espacamento no eixo principal
        ),
        children: provider.getCountries().map((country) {
          return CountryItem(country);
        }).toList(),
      ),
    );
  }
}
