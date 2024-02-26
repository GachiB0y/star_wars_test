import 'package:sizzle_starter/src/core/components/rest_client/rest_client.dart';
import 'package:sizzle_starter/src/feature/search/model/entity.dart';

abstract interface class ISearchProvider {
  ///Метод для получения людей

  Future<List<People>> getPeople({required String name});

  ///Метод для получения кораблей

  Future<List<StarShip>> getStarShip({required String name});
}

class SearchProviderImpl implements ISearchProvider {
  final RestClient _httpService;
  SearchProviderImpl(this._httpService);

  @override
  Future<List<People>> getPeople({required String name}) async {
    final response = await _httpService.get(
      '/bus/get_destination',
      queryParams: {
        'search': name,
      },
    );

    if (response case {'result': final data as List<Map<String, dynamic>>}) {
      final List<People> result =
          data.map((item) => People.fromJson(item)).toList();

      return result;
    }
    throw Exception('Error fetching get People');
  }

  @override
  Future<List<StarShip>> getStarShip({required String name}) async {
    final response = await _httpService.get(
      '/bus/get_destination',
      queryParams: {
        'search': name,
      },
    );

    if (response case {'result': final data as List<Map<String, dynamic>>}) {
      final List<StarShip> result =
          data.map((item) => StarShip.fromJson(item)).toList();

      return result;
    }
    throw Exception('Error fetching get StarShip');
  }
}
