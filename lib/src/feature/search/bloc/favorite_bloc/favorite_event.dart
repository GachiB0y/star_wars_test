part of 'favorite_bloc.dart';

/// Business Logic Component Favorite Events
@freezed
class FavoriteEvent with _$FavoriteEvent {
  const FavoriteEvent._();

  /// Create
  const factory FavoriteEvent.create({required String name}) =
      CreateFavoriteEvent;

  /// Fetch
  const factory FavoriteEvent.fetch() = FetchFavoriteEvent;

  /// Delete
  const factory FavoriteEvent.delete({required String name}) =
      DeleteFavoriteEvent;
}
