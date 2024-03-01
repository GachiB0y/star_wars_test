part of 'search_bloc.dart';

/// Business Logic Component SearchEvent Events
@freezed
class SearchEvent with _$SearchEvent {
  const SearchEvent._();

  /// Fetch
  const factory SearchEvent.fetch({required String name}) = FetchSearchEvent;

  /// FetchFavorite
  const factory SearchEvent.fetchFavorite({required List<String> names}) =
      FetchFavoriteSearchEvent;
}
