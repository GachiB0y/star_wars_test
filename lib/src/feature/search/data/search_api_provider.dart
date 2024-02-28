import 'package:sizzle_starter/src/core/components/rest_client/rest_client.dart';
import 'package:sizzle_starter/src/feature/search/model/entity.dart';

abstract interface class ISearchProvider {
  ///Метод для получения людей

  Future<Iterable<People>> getPeople({required String name});

  ///Метод для получения кораблей

  Future<Iterable<StarShip>> getStarShip({required String name});
}

class SearchProviderImpl implements ISearchProvider {
  final RestClient _httpService;
  SearchProviderImpl(
    this._httpService,
  );

  @override
  Future<Iterable<People>> getPeople({required String name}) async {
    final response = await _httpService.get(
      '/api/people',
      queryParams: {
        'search': name,
      },
    );

    if (response case {'results': final data as List<dynamic>}) {
      if (response case {'count': final count}) {
        if (count == 0) {
          return [];
        }
      }

      final Iterable<People> result =
          data.map((item) => People.fromJson(item as Map<String, dynamic>));

      // final Iterable<People> result = await Future.wait(
      //   data.map<Future<People>>((item) async {
      //     final coolletionItemLink = item['starships'] as List<dynamic>;
      //     late final Iterable<StarShip> starships;
      //     if (coolletionItemLink.isEmpty) {
      //       starships = [];
      //     } else {
      //       starships = await Future.wait(
      //         coolletionItemLink.map((url) async {
      //           final response =
      //               await _httpService.get(url.substring(18) as String);

      //           if (response case {'name': final data as String}) {
      //             return StarShip(
      //               pilots: [],
      //               name: response['name']! as String,
      //               manufacturer: response['manufacturer']! as String,
      //             );
      //           }
      //           throw Exception('Error fetching get list starship');
      //         }),
      //       );
      //     }

      //     return People(
      //       name: item['name'] as String,
      //       gender: item['gender'] as String,
      //       starships: starships.toList(),
      //     );
      //   }),
      // );

      return result;
    }
    throw Exception('Error fetching get People');
  }

  @override
  Future<Iterable<StarShip>> getStarShip({required String name}) async {
    final response = await _httpService.get(
      '/api/starships',
      queryParams: {
        'search': name,
      },
    );

    if (response case {'results': final data as List<dynamic>}) {
      if (response case {'count': final count}) {
        if (count == 0) {
          return [];
        }
      }

      final Iterable<StarShip> result =
          data.map((item) => StarShip.fromJson(item as Map<String, dynamic>));

      // final Iterable<StarShip> result = await Future.wait(

      //   data.map<Future<StarShip>>((item) async {
      //     final coolletionItemLink = item['pilots'] as List<dynamic>;
      //     late final Iterable<People> pilots;
      //     if (coolletionItemLink.isEmpty) {
      //       pilots = [];
      //     } else {
      //       pilots = await Future.wait(
      //         coolletionItemLink.map((url) async {
      //           final response =
      //               await _httpService.get(url.substring(18) as String);

      //           if (response case {'name': final data as String}) {
      //             return People(
      //               starships: [],
      //               name: response['name']! as String,
      //               gender: response['gender']! as String,
      //             );
      //           }
      //           throw Exception('Error fetching get list starship');
      //         }),
      //       );
      //     }

      //     return StarShip(
      //       name: item['name'] as String,
      //       manufacturer: item['manufacturer'] as String,
      //       pilots: pilots.toList(),
      //     );
      //   }),
      // );

      // final List<StarShip> result = data
      //     .map((item) => StarShip.fromJson(item as Map<String, dynamic>))
      //     .toList();

      return result;
    }
    throw Exception('Error fetching get StarShip');
  }
}
