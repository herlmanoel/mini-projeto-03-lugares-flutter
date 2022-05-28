class Place {
  final String id;
  final List<String> paises;
  final String titulo;
  final String imagemUrl;
  final List<String> recomendacoes;
  final double avaliacao;
  final double custoMedio;
  bool isFavorite;

  Place({
    required this.id,
    required this.paises,
    required this.titulo,
    required this.imagemUrl,
    required this.recomendacoes,
    required this.avaliacao,
    required this.custoMedio,
    this.isFavorite = false,
  });

  setFavorite(bool value) {
    isFavorite = value;
  }

  set id(String value) {
    id = value;
  }

  @override
  String toString() {
    return 'Place{id: $id, paises: $paises, titulo: $titulo, imagemUrl: $imagemUrl, recomendacoes: $recomendacoes, avaliacao: $avaliacao, custoMedio: $custoMedio, isFavorite: $isFavorite}';
  }
}
