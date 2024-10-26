import 'dart:developer';

import '../models/character_model.dart';
import '../services/character_service.dart';

// character_repo.dart
class CharacterRepo {
  final CharacterService characterService;

  CharacterRepo(this.characterService);

  // Get characters through the API service with pagination
  Future<List<CharacterModel>> getCharacters({required int page}) async {
    final characters = await characterService.fetchCharacters(page: page);
    if (characters.isNotEmpty) {
      return characters.map((e) => CharacterModel.fromJson(e)).toList();
    } else {
      log("No characters and invalid response");
      return [];
    }
  }
}

