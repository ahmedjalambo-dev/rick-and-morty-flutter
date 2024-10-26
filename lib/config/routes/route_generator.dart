import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/widgets/not_found_screen.dart';
import 'package:rick_and_morty/features/characters/cubit/characters_cubit.dart';
import 'package:rick_and_morty/features/characters/db/repos/character_repo.dart';
import 'package:rick_and_morty/features/characters/ui/screens/characters_screen.dart';
import 'package:rick_and_morty/features/characters/ui/screens/details_screen.dart';

import '../../features/characters/db/services/character_service.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(
          builder: (_) => BlocProvider<CharactersCubit>(
            create: (BuildContext context) =>
                CharactersCubit(CharacterRepo(CharacterService())),
            child: const CharactersScreen(),
          ),
        );
      case '/details':
        return CupertinoPageRoute(
          builder: (_) => const DetailsScreen(),
        );

      default:
        return _errorRoute();
    }
  }

  // Error route for undefined routes
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const NotFoundScreen();
    });
  }
}
