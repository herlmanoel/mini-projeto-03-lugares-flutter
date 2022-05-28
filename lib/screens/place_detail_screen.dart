import 'package:f3_lugares/models/place.dart';
import 'package:f3_lugares/models/places_items.dart';
import 'package:f3_lugares/utils/app_routes.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final place = ModalRoute.of(context)?.settings.arguments as Place;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.titulo),
      ),
      /*
      body: Center(
        child: Text('Detalhes da Lugar!'),
      ),*/
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                place.imagemUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Dicas',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              width: 300,
              height: 250,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: ListView.builder(
                  itemCount: place.recomendacoes.length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            child: Text('${index + 1}'),
                          ),
                          title: Text(place.recomendacoes[index]),
                          subtitle: Text(place.titulo),
                          onTap: () {
                            print(place.recomendacoes[index]);
                          },
                        ),
                        const Divider(),
                      ],
                    );
                  }),
            ),
            // row com botões para alterar e remover place
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: const Text('Editar'),
                  onPressed: () {
                    _showDialogEditPlace(context, place);
                  },
                ),
                ElevatedButton(
                  child: const Text('Remover'),
                  onPressed: () {
                    _showDialogRemovePlace(context, place);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(place.titulo);
        },
        child: const Icon(Icons.star),
      ),
    );
  }

  _showDialogRemovePlace(BuildContext context, place) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Tem certeza?'),
            content:
                Text('Você realmente deseja remover o lugar ${place.titulo}?'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Remover'),
                onPressed: () {
                  Navigator.of(context).pop();
                  final provider =
                      Provider.of<PlacesItems>(context, listen: false);
                  provider.removePlace(place.id);
                  Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
                },
              ),
            ],
          );
        });
  }

  _showDialogEditPlace(BuildContext context, place) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Tem certeza?'),
            content:
                Text('Você realmente editar o lugar ${place.titulo}?'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Editar'),
                onPressed: () {
                  Navigator.of(context)
                        .pushNamed(AppRoutes.ADD_PLACE, arguments: place);
                },
              ),
            ],
          );
        });
  }
}
