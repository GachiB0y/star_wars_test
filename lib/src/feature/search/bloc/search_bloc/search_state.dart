part of 'search_bloc.dart';

/// {@template search_state_placeholder}
/// Entity placeholder for SearchState
/// {@endtemplate}
typedef SearchEntity = SearchModel;

/// {@template search_state}
/// SearchState.
/// {@endtemplate}
sealed class SearchState extends _$SearchStateBase {
  /// {@macro search_state}
  const SearchState({required super.data, required super.message});

  /// Idling state
  /// {@macro search_state}
  const factory SearchState.idle({
    required SearchEntity? data,
    String message,
  }) = SearchState$Idle;

  /// Processing
  /// {@macro search_state}
  const factory SearchState.processing({
    required SearchEntity? data,
    String message,
  }) = SearchState$Processing;

  /// Successful
  /// {@macro search_state}
  const factory SearchState.successful({
    required SearchEntity? data,
    String message,
  }) = SearchState$Successful;

  /// An error has occurred
  /// {@macro search_state}
  const factory SearchState.error({
    required SearchEntity? data,
    String message,
  }) = SearchState$Error;
}

/// Idling state
/// {@nodoc}
final class SearchState$Idle extends SearchState with _$SearchState {
  /// {@nodoc}
  const SearchState$Idle({required super.data, super.message = 'Idling'});
}

/// Processing
/// {@nodoc}
final class SearchState$Processing extends SearchState with _$SearchState {
  /// {@nodoc}
  const SearchState$Processing({
    required super.data,
    super.message = 'Processing',
  });
}

/// Successful
/// {@nodoc}
final class SearchState$Successful extends SearchState with _$SearchState {
  /// {@nodoc}
  const SearchState$Successful({
    required super.data,
    super.message = 'Successful',
  });
}

/// Error
/// {@nodoc}
final class SearchState$Error extends SearchState with _$SearchState {
  /// {@nodoc}
  const SearchState$Error({
    required super.data,
    super.message = 'An error has occurred.',
  });
}

/// {@nodoc}
base mixin _$SearchState on SearchState {}

/// Pattern matching for [SearchState].
typedef SearchStateMatch<R, S extends SearchState> = R Function(S state);

/// {@nodoc}
@immutable
abstract base class _$SearchStateBase {
  /// {@nodoc}
  const _$SearchStateBase({required this.data, required this.message});

  /// Data entity payload.
  @nonVirtual
  final SearchEntity? data;

  /// Message or state description.
  @nonVirtual
  final String message;

  /// Has data?
  bool get hasData => data != null;

  /// If an error has occurred?
  bool get hasError => maybeMap<bool>(orElse: () => false, error: (_) => true);

  /// Is in progress state?
  bool get isProcessing =>
      maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [SearchState].
  R map<R>({
    required SearchStateMatch<R, SearchState$Idle> idle,
    required SearchStateMatch<R, SearchState$Processing> processing,
    required SearchStateMatch<R, SearchState$Successful> successful,
    required SearchStateMatch<R, SearchState$Error> error,
  }) =>
      switch (this) {
        final SearchState$Idle s => idle(s),
        final SearchState$Processing s => processing(s),
        final SearchState$Successful s => successful(s),
        final SearchState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [SearchState].
  R maybeMap<R>({
    required R Function() orElse,
    SearchStateMatch<R, SearchState$Idle>? idle,
    SearchStateMatch<R, SearchState$Processing>? processing,
    SearchStateMatch<R, SearchState$Successful>? successful,
    SearchStateMatch<R, SearchState$Error>? error,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [SearchState].
  R? mapOrNull<R>({
    SearchStateMatch<R, SearchState$Idle>? idle,
    SearchStateMatch<R, SearchState$Processing>? processing,
    SearchStateMatch<R, SearchState$Successful>? successful,
    SearchStateMatch<R, SearchState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        error: error ?? (_) => null,
      );

  @override
  int get hashCode => data.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);
}
