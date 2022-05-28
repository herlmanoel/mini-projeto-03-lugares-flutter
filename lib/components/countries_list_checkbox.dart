import 'package:f3_lugares/models/country.dart';
import 'package:f3_lugares/models/places_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountriesListCheckbox extends StatefulWidget {
  List<String> countriesIds;
  CountriesListCheckbox({ required this.countriesIds, Key? key}) : super(key: key);

  @override
  State<CountriesListCheckbox> createState() => _CountriesListCheckboxState();
}

class _CountriesListCheckboxState extends State<CountriesListCheckbox> {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: checkboxList(),
    );
  }

  Container checkboxItem(Country country) {
    return Container(
      child: CheckboxListTile(
        title: Text(country.title),
        value: widget.countriesIds.contains(country.id),
        onChanged: (bool? value) {
          bool containsId = widget.countriesIds.contains(country.id);
          if (value == true) {
            if (!containsId) {
              widget.countriesIds.add(country.id);
              setState(() { });
            }
          } else {
            if(containsId) {
              widget.countriesIds.remove(country.id);
            }
            setState(() { });
          }
        },
      ),
    );
  }

  Widget checkboxList() {
    return SizedBox(
      height: 300,
      child: Consumer<PlacesItems>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.countries.length,
            itemBuilder: (context, index) {
              final Country country = value.countries[index];
              return checkboxItem(country);
            },
          );
        },
      ),
    );
  }
}
