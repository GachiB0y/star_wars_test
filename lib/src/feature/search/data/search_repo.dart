import 'package:sizzle_starter/src/feature/search/data/search_api_provider.dart';
import 'package:sizzle_starter/src/feature/search/model/entity.dart';

abstract interface class ISearchRepository {
  ///Метод для поиска

  Future<SearchModel> serach({required String name});
}

/// Repository for searching and retrieving data.
class SearchRepositoryImpl implements ISearchRepository {
  /// Repository for searching and retrieving data.

  SearchRepositoryImpl({
    required ISearchProvider scheduleBusProvider,
  }) : _scheduleBusProvider = scheduleBusProvider;

  final ISearchProvider _scheduleBusProvider;

  @override
  Future<SearchModel> serach({required String name}) async {
    final Iterable<People> peoples =
        await _scheduleBusProvider.getPeople(name: name);
    final Iterable<StarShip> starships =
        await _scheduleBusProvider.getStarShip(name: name);

    final List<CombinedData> dataOne = peoples
        .map((people) => CombinedData.fromPeopleAndStarship(people, null))
        .toList();
    final Iterable<CombinedData> dataTwo = starships
        .map((starship) => CombinedData.fromPeopleAndStarship(null, starship));
    dataOne.addAll(dataTwo);
    final SearchModel result = SearchModel(
      combinedData: dataOne,
    );

    return result;
  }
}
