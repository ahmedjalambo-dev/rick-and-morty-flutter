part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

final class CharactersLoading extends CharactersState {
  final List<CharacterModel> oldCharacters;
  final bool isFirstFetch;

  CharactersLoading(this.oldCharacters, {this.isFirstFetch = false});
}

final class CharactersSuccess extends CharactersState {
  final List<CharacterModel> characters;

  CharactersSuccess(this.characters);
}

final class CharactersFailure extends CharactersState {
  final String errorMessage;
  CharactersFailure(this.errorMessage);
}
