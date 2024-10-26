import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:rick_and_morty/features/characters/db/models/character_model.dart';
import 'package:rick_and_morty/features/characters/db/repos/character_repo.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepo characterRepo;
  int currentPage = 1;
  bool isFetching = false;

  CharactersCubit(this.characterRepo) : super(CharactersInitial());

  void getCharacters() async {
    // Prevent multiple simultaneous requests
    if (state is CharactersLoading) return;

    // Capture the current state and retain old characters
    final currentState = state;
    var oldCharacters = <CharacterModel>[];

    if (currentState is CharactersSuccess) {
      oldCharacters = currentState.characters;
    }

    // Emit loading state with old characters,
    // and isFirstFetch is true only if on the first page
    emit(CharactersLoading(oldCharacters, isFirstFetch: currentPage == 1));

    try {
      // Fetch characters from the repository
      final newCharacters =
          await characterRepo.getCharacters(page: currentPage);

      // Increment page number if characters were successfully loaded
      currentPage++;

      // Combine old and new characters
      final allCharacters = [...oldCharacters, ...newCharacters];

      // Emit success state with the full list of characters
      emit(CharactersSuccess(allCharacters));
    } catch (e) {
      // Emit failure state in case of an error
      emit(CharactersFailure("Error loading characters: ${e.toString()}"));
    }
  }
}
