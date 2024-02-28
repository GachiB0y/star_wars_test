import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizzle_starter/src/feature/search/data/search_api_provider.dart';
import 'package:sizzle_starter/src/feature/search/model/entity.dart';

abstract interface class ISearchRepository {
  ///Метод для поиска
  Future<SearchModel> serach({required String name});

  // Получение изранного

  Future<Set<ProductID>> fetchFavoriteProducts();

  /// Сохрнание данных в избарнное
  Future<void> addFavoriteProduct(ProductID id);

  /// Удаление данных из избарнное
  Future<void> removeFavoriteProduct(ProductID id);
}

/// Repository for searching and retrieving data.
class SearchRepositoryImpl implements ISearchRepository {
  /// Repository for searching and retrieving data.

  SearchRepositoryImpl({
    required ISearchProvider scheduleBusProvider,
    required SharedPreferences sharedPreferences,
  })  : _scheduleBusProvider = scheduleBusProvider,
        _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static const String _favoriteProductsKey = 'starwars.products.favorite';

  final ISearchProvider _scheduleBusProvider;

  Set<ProductID>? _favoritesCache;

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

  @override
  Future<Set<ProductID>> fetchFavoriteProducts() async {
    if (_favoritesCache case final Set<ProductID> cache) {
      return Set<ProductID>.of(cache);
    }
    final set = _sharedPreferences.getStringList(_favoriteProductsKey);
    if (set == null) return <ProductID>{};
    return Set<ProductID>.of(
      _favoritesCache = set.toSet(),
    );
  }

  @override
  Future<void> addFavoriteProduct(ProductID id) async {
    final set = await fetchFavoriteProducts();
    if (!set.add(id)) return;
    _favoritesCache = set;
    await _sharedPreferences.setStringList(
      _favoriteProductsKey,
      <String>[
        ...set,
        id.toString(),
      ],
    );
  }

  @override
  Future<void> removeFavoriteProduct(ProductID id) async {
    final set = await fetchFavoriteProducts();
    if (!set.remove(id)) return;
    _favoritesCache = set;
    await _sharedPreferences.setStringList(
      _favoriteProductsKey,
      <String>[...set],
    );
  }
}
