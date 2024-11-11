import 'dart:developer';
import 'package:dio/dio.dart';

class CharacterService {
  late Dio _dio;
  static const String baseUrl = 'https://rickandmortyapi.com/api/';

  CharacterService() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      // receiveTimeout: const Duration(seconds: 5),
      // connectTimeout: const Duration(seconds: 5),
    );
    _dio = Dio(baseOptions);
  }

  // Fetch character data with pagination
  Future<List<dynamic>> fetchCharacters(
      {required int page, String? characterName}) async {
    try {
      late Response response;

      if (characterName == null) {
        response = await _dio.get('character', queryParameters: {
          'page': page,
        });
      } else {
        response = await _dio.get('character', queryParameters: {
          'page': page,
          'name': characterName,
        });
      }

      log("Response data for page $page: ${response.data}");

      if (response.data != null && response.data['results'] != null) {
        return response.data['results'];
      } else {
        log("API response is null or doesn't contain 'results'");
        return [];
      }
    } catch (e) {
      log("Error fetching characters: ${e.toString()}");
      return [];
    }
  }

  // Fetch episode details by URL
  Future<String?> fetchEpisodeName(String episodeUrl) async {
    try {
      final response = await _dio.get(episodeUrl);
      if (response.data != null && response.data['name'] != null) {
        return response.data['name'];
      } else {
        log("Episode data is null or doesn't contain 'name'");
        return null;
      }
    } catch (e) {
      log("Error fetching episode: ${e.toString()}");
      return null;
    }
  }
}
