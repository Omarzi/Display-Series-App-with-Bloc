import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'busniss_logic/cubit/characters_cubit.dart';
import 'constants/strings.dart';
import 'data/models/characters.dart';
import 'data/models/quote.dart';
import 'data/repository/character_repository.dart';
import 'data/web_services/character_web_services.dart';
import 'presentation/screens/character_screen.dart';
import 'presentation/screens/characters_details_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  // ignore: body_might_complete_normally_nullable
  Route? gnerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case 1
      case charactersScren:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );

      // case 2
      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(charactersRepository),
            child: CharacterDetailsScreen(
              character: character,
            ),
          ),
        );
    }
  }
}
