
import '../models/character_model.dart';
import '../services/character_service.dart';

class CharacterRepo {
  final CharacterService characterService;

  CharacterRepo(this.characterService);

  // Get characters with pagination and optional search, plus first seen episode
  Future<List<CharacterModel>> getCharacters(
      {required int page, String? characterName}) async {
    final charactersData = await characterService.fetchCharacters(
        page: page, characterName: characterName);

    List<CharacterModel> characters = [];

    for (var characterJson in charactersData) {
      CharacterModel character = CharacterModel.fromJson(characterJson);

      // Fetch the first episode's name if episode URLs are available
      if (characterJson['episode'] != null &&
          characterJson['episode'].isNotEmpty) {
        String firstEpisodeUrl = characterJson['episode'][0];
        character.firstSeenEpisode =
            await characterService.fetchEpisodeName(firstEpisodeUrl);
      } else {
        character.firstSeenEpisode = 'Unknown';
      }

      characters.add(character);
    }

    return characters;
  }
}
