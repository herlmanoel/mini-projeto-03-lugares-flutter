import 'package:f3_lugares/components/countries_list_checkbox.dart';
import 'package:f3_lugares/models/place.dart';
import 'package:f3_lugares/models/places_items.dart';
import 'package:f3_lugares/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PlaceForm extends StatefulWidget {
  @override
  State<PlaceForm> createState() => _PlaceFormState();
}

class _PlaceFormState extends State<PlaceForm> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlacesItems>(context, listen: false);
    bool isEditing = ModalRoute.of(context)?.settings.arguments != null;
    TextEditingController nomeController = TextEditingController();
    TextEditingController custoController = TextEditingController();
    TextEditingController urlController = TextEditingController();
    TextEditingController recomendacoesController = TextEditingController();
    List<String> countriesIds = [];

    if (ModalRoute.of(context)?.settings.arguments != null) {
      final placeRoute = ModalRoute.of(context)?.settings.arguments as Place;
      nomeController.text = placeRoute.titulo;
      custoController.text = placeRoute.custoMedio.toString();
      urlController.text = placeRoute.imagemUrl;
      recomendacoesController.text = placeRoute.recomendacoes.join(';');
      // pegar ids da lista de title dos placeRoute
      countriesIds = placeRoute.paises;
    }

    void addLugar(String nome, double custo, String url, String recomendacoes) {
      List<String> recomendacoesList = recomendacoes.split(';');

      final Place place = Place(
        id: ModalRoute.of(context)?.settings.arguments != null
            ? (ModalRoute.of(context)?.settings.arguments as Place).id
            : DateTime.now().toString(),
        titulo: nome,
        paises: countriesIds,
        avaliacao: 4.8,
        custoMedio: custo,
        recomendacoes: recomendacoesList,
        imagemUrl: url,
      );

      if (ModalRoute.of(context)?.settings.arguments != null) {
        final placeRoute = ModalRoute.of(context)?.settings.arguments as Place;
        provider.updatePlace(place);
      } else {
        provider.addPlace(place);
      }

      Navigator.of(context).pushNamed("/");
      String message =
          ModalRoute.of(context)?.settings.arguments != null
              ? "Lugar atualizado com sucesso!"
              : "Lugar adicionado com sucesso!";
    
     SnackBar snackBar = SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Show Snackbar',
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
          },
        ),
        title: const Text("Adicionar Lugar"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  "Adicionar Lugar",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Lugar',
                  ),
                ),
                TextField(
                  controller: custoController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Custo médio',
                  ),
                ),
                TextField(
                  controller: urlController,
                  decoration: const InputDecoration(
                    labelText: 'URL da Imagem',
                  ),
                ),
                CountriesListCheckbox(countriesIds: countriesIds),
                TextField(
                  controller: recomendacoesController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Recomendações',
                    hintText: 'Separar com ;',
                  ),
                ),
                ElevatedButton(
                  child: const Text("Adicionar"),
                  onPressed: () => addLugar(
                      nomeController.text,
                      double.parse(custoController.text),
                      urlController.text,
                      recomendacoesController.text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
