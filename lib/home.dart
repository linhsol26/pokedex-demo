import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokedex/cubits/nav/nav_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoadingProgress) {
            return Center(
                child: CircularProgressIndicator(color: Colors.blueGrey));
          } else if (state is PokemonPageLoadFailed) {
            return Center(child: Text(state.error.toString()));
          } else if (state is PokemonPageLoadSuccess) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: state.pokemonListings.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () => BlocProvider.of<NavCubit>(context)
                          .showPokemonDetails(state.pokemonListings[index].id),
                      child: Card(
                        child: GridTile(
                          child: Column(
                            children: [
                              Image.network(
                                  state.pokemonListings[index].imageUrl),
                              Text(state.pokemonListings[index].name),
                            ],
                          ),
                        ),
                      ),
                    ));
          }
          return Container();
        },
      ),
    );
  }
}
