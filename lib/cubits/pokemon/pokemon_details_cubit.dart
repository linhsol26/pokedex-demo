import 'package:bloc/bloc.dart';
import 'package:pokedex/pokemon_details.dart';
import 'package:pokedex/pokemon_info_repository.dart';
import 'package:pokedex/pokemon_repository.dart';
import 'package:pokedex/pokemon_species_info.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetails> {
  PokemonDetailsCubit()
      : super(
          PokemonDetails(
              id: -1,
              name: '',
              imageUrl: '',
              types: [],
              height: 0,
              description: '',
              weight: 0),
        );

  final PokemonReposity _pokemonReposity = PokemonReposity();

  void clearPokemonDetails() {
    emit(
      PokemonDetails(
          id: -1,
          name: '',
          imageUrl: '',
          types: [],
          height: 0,
          description: '',
          weight: 0),
    );
  }

  void getPokemonDetails(int id) async {
    final response = await Future.wait([
      _pokemonReposity.getPokemonInfo(id),
      _pokemonReposity.getPokemonSpeciesInfo(id),
    ]);

    final pokemonInfo = response[0] as PokemonInfoResponse;
    final speciesInfo = response[1] as PokemonSpeciesInfoResponse;

    emit(PokemonDetails(
        id: pokemonInfo.id,
        name: pokemonInfo.name,
        imageUrl: pokemonInfo.imageUrl,
        types: pokemonInfo.types,
        height: pokemonInfo.height,
        description: speciesInfo.description,
        weight: pokemonInfo.weight));
  }
}
