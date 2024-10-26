import 'dart:developer';
import 'package:dio/dio.dart';

class CharacterService {
  late Dio _dio;
  static const String baseUrl = 'https://rickandmortyapi.com/api/';

  CharacterService() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 120),
      connectTimeout: const Duration(seconds: 120),
    );
    _dio = Dio(baseOptions);
  }

  // Fetch character data with pagination
  Future<List<dynamic>> fetchCharacters({required int page}) async {
    try {
      Response response =
          await _dio.get('character', queryParameters: {'page': page});

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
}
