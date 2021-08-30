import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/pokemon_info_repository.dart';
import 'package:pokedex/pokemon_page_response.dart';
import 'package:pokedex/pokemon_species_info.dart';

class PokemonReposity {
  final baseUrl = 'pokeapi.co';
  final client = http.Client();

  Future<PokemonPageResponse> getPokemonPage(int pageIndex) async {
    final queryParams = {
      'limit': '200',
      'offset': (pageIndex * 200).toString(),
    };

    final uri = Uri.https(baseUrl, 'api/v2/pokemon', queryParams);

    final response = await client.get(uri);
    final json = jsonDecode(response.body);

    return PokemonPageResponse.fromJson(json);
  }

  Future<PokemonSpeciesInfoResponse> getPokemonSpeciesInfo(
      int pokemonId) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon-species/$pokemonId');

    try {
      final response = await client.get(uri);
      final json = jsonDecode(response.body);
      return PokemonSpeciesInfoResponse.fromJson(json);
    } catch (e) {
      return throw Error();
    }
  }

  Future<PokemonInfoResponse> getPokemonInfo(int pokemonId) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon/$pokemonId');

    try {
      final response = await client.get(uri);
      final json = jsonDecode(response.body);
      return PokemonInfoResponse.fromJson(json);
    } catch (e) {
      return throw Error();
    }
  }
}
