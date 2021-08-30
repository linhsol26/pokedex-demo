import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/cubits/nav/nav_cubit.dart';
import 'package:pokedex/pokemon_details_view.dart';

import 'home.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, int>(
      builder: (context, state) {
        return Navigator(
          pages: [
            MaterialPage(child: HomePage()),
            if (state != -1) MaterialPage(child: PokemonDetailsView())
          ],
          onPopPage: (route, result) {
            BlocProvider.of<NavCubit>(context).popThePokedex();
            return route.didPop(result);
          },
        );
      },
    );
  }
}
