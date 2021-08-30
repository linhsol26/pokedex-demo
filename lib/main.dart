import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app_navigation.dart';
import 'package:pokedex/cubits/nav/nav_cubit.dart';
import 'package:pokedex/cubits/pokemon/pokemon_details_cubit.dart';

import 'blocs/pokemon/pokemon_bloc.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final PokemonDetailsCubit _pokemonDetailsCubit = PokemonDetailsCubit();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (_) => PokemonBloc()..add(PokemonPageRequest(page: 0)),
        ),
        BlocProvider(create: (_) => _pokemonDetailsCubit),
        BlocProvider(
            create: (_) => NavCubit(pokemonDetailsCubit: _pokemonDetailsCubit))
      ], child: AppNavigator()),
    );
  }
}
