part of 'search_bloc.dart';

/// Business Logic Component SearchEvent Events
@freezed
class SearchEventEvent with _$SearchEventEvent {
  const SearchEventEvent._();



  /// Fetch
  const factory SearchEventEvent.fetch({required String name id}) = FetchSearchEventEvent;





}
