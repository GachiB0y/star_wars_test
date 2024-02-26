import 'package:sizzle_starter/src/feature/search/data/search_api_provider.dart';
import 'package:sizzle_starter/src/feature/search/model/entity.dart';

abstract interface class ISearchRepository {
  ///Метод для получения людей

  Future<List<People>> getPeople({required String name});

  ///Метод для получения кораблей

  Future<List<StarShip>> getStarShip({required String name});
}

class SearchRepositoryImpl implements ISearchRepository {
  SearchRepositoryImpl({
    required ISearchProvider scheduleBusProvider,
  }) : _scheduleBusProvider = scheduleBusProvider;

  final ISearchProvider _scheduleBusProvider;

  @override
  Future<List<People>> getPeople({required String name}) async =>
      _scheduleBusProvider.getPeople(name: name);
  @override
  Future<List<StarShip>> getStarShip({required String name}) async =>
      _scheduleBusProvider.getStarShip(name: name);
}
