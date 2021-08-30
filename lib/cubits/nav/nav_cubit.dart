import 'package:bloc/bloc.dart';
import 'package:pokedex/cubits/pokemon/pokemon_details_cubit.dart';

class NavCubit extends Cubit<int> {
  PokemonDetailsCubit pokemonDetailsCubit;

  NavCubit({required this.pokemonDetailsCubit}) : super(-1);

  void showPokemonDetails(int pokemonId) {
    pokemonDetailsCubit.getPokemonDetails(pokemonId);
    emit(pokemonId);
  }

  void popThePokedex() {
    emit(-1);
  }
}
