part of 'favorite_bloc.dart';

/// {@template favorite_state_placeholder}
/// Entity placeholder for FavoriteState
/// {@endtemplate}
typedef FavoriteEntity = Set<String>;

/// {@template favorite_state}
/// FavoriteState.
/// {@endtemplate}
sealed class FavoriteState extends _$FavoriteStateBase {
  /// {@macro favorite_state}
  const FavoriteState({required super.data, required super.message});

  /// Idling state
  /// {@macro favorite_state}
  const factory FavoriteState.idle({
    required FavoriteEntity? data,
    String message,
  }) = FavoriteState$Idle;

  /// Processing
  /// {@macro favorite_state}
  const factory FavoriteState.processing({
    required FavoriteEntity? data,
    String message,
  }) = FavoriteState$Processing;

  /// Successful
  /// {@macro favorite_state}
  const factory FavoriteState.successful({
    required FavoriteEntity? data,
    String message,
  }) = FavoriteState$Successful;

  /// An error has occurred
  /// {@macro favorite_state}
  const factory FavoriteState.error({
    required FavoriteEntity? data,
    String message,
  }) = FavoriteState$Error;
}

/// Idling state
/// {@nodoc}
final class FavoriteState$Idle extends FavoriteState with _$FavoriteState {
  /// {@nodoc}
  const FavoriteState$Idle({required super.data, super.message = 'Idling'});
}

/// Processing
/// {@nodoc}
final class FavoriteState$Processing extends FavoriteState
    with _$FavoriteState {
  /// {@nodoc}
  const FavoriteState$Processing({
    required super.data,
    super.message = 'Processing',
  });
}

/// Successful
/// {@nodoc}
final class FavoriteState$Successful extends FavoriteState
    with _$FavoriteState {
  /// {@nodoc}
  const FavoriteState$Successful({
    required super.data,
    super.message = 'Successful',
  });
}

/// Error
/// {@nodoc}
final class FavoriteState$Error extends FavoriteState with _$FavoriteState {
  /// {@nodoc}
  const FavoriteState$Error({
    required super.data,
    super.message = 'An error has occurred.',
  });
}

/// {@nodoc}
base mixin _$FavoriteState on FavoriteState {}

/// Pattern matching for [FavoriteState].
typedef FavoriteStateMatch<R, S extends FavoriteState> = R Function(S state);

/// {@nodoc}
@immutable
abstract base class _$FavoriteStateBase {
  /// {@nodoc}
  const _$FavoriteStateBase({required this.data, required this.message});

  /// Data entity payload.
  @nonVirtual
  final FavoriteEntity? data;

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

  /// Pattern matching for [FavoriteState].
  R map<R>({
    required FavoriteStateMatch<R, FavoriteState$Idle> idle,
    required FavoriteStateMatch<R, FavoriteState$Processing> processing,
    required FavoriteStateMatch<R, FavoriteState$Successful> successful,
    required FavoriteStateMatch<R, FavoriteState$Error> error,
  }) =>
      switch (this) {
        final FavoriteState$Idle s => idle(s),
        final FavoriteState$Processing s => processing(s),
        final FavoriteState$Successful s => successful(s),
        final FavoriteState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [FavoriteState].
  R maybeMap<R>({
    required R Function() orElse,
    FavoriteStateMatch<R, FavoriteState$Idle>? idle,
    FavoriteStateMatch<R, FavoriteState$Processing>? processing,
    FavoriteStateMatch<R, FavoriteState$Successful>? successful,
    FavoriteStateMatch<R, FavoriteState$Error>? error,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [FavoriteState].
  R? mapOrNull<R>({
    FavoriteStateMatch<R, FavoriteState$Idle>? idle,
    FavoriteStateMatch<R, FavoriteState$Processing>? processing,
    FavoriteStateMatch<R, FavoriteState$Successful>? successful,
    FavoriteStateMatch<R, FavoriteState$Error>? error,
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
