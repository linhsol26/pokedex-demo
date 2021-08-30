class PokemonPageResponse {
  final List<PokemonListing> pokemonListings;
  final bool canLoadNextPage;

  PokemonPageResponse(
      {required this.canLoadNextPage, required this.pokemonListings});

  factory PokemonPageResponse.fromJson(Map<String, dynamic> json) {
    final canLoadNextPage = json['next'] != null;
    final pokemonListings = (json['results'] as List)
        .map((e) => PokemonListing.fromJson(e))
        .toList();
    return PokemonPageResponse(
        canLoadNextPage: canLoadNextPage, pokemonListings: pokemonListings);
  }
}

class PokemonListing {
  final int id;
  final String name;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${id.toString()}.png';

  PokemonListing({required this.id, required this.name});

  factory PokemonListing.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final url = json['url'] as String;
    final id = int.parse(url.split('/')[6]);

    return PokemonListing(id: id, name: name);
  }
}
