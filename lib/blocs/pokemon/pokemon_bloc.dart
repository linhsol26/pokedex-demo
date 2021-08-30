import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/pokemon_page_response.dart';
import 'package:pokedex/pokemon_repository.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonReposity _pokemonReposity = PokemonReposity();
  PokemonBloc() : super(PokemonInitial());

  @override
  Stream<PokemonState> mapEventToState(
    PokemonEvent event,
  ) async* {
    if (event is PokemonPageRequest) {
      yield PokemonLoadingProgress();

      try {
        final pokemonPageRequest =
            await _pokemonReposity.getPokemonPage(event.page);
        yield PokemonPageLoadSuccess(
            pokemonListings: pokemonPageRequest.pokemonListings,
            canLoadNextPage: pokemonPageRequest.canLoadNextPage);
      } catch (e) {
        yield PokemonPageLoadFailed(error: e as Error);
      }
    }
  }
}
