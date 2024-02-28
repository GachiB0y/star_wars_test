// ignore_for_file: unused_catch_stack

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sizzle_starter/src/feature/search/data/search_repo.dart';

part 'favorite_bloc.freezed.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

/// Business Logic Component FavoriteBLoC
class FavoriteBLoC extends Bloc<FavoriteEvent, FavoriteState>
    implements EventSink<FavoriteEvent> {
  FavoriteBLoC({
    required final ISearchRepository repository,
    final FavoriteState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              FavoriteState.idle(
                data: FavoriteEntity(),
                message: 'Initial idle state',
              ),
        ) {
    on<FavoriteEvent>(
      (event, emit) => event.map<Future<void>>(
        fetch: (event) => _fetch(event, emit),
        create: (event) => _addFavoriteProduct(event, emit),
        delete: (event) => _deleteFavoriteProduct(event, emit),
      ),
      transformer: bloc_concurrency.sequential(),
      //transformer: bloc_concurrency.restartable(),
      //transformer: bloc_concurrency.droppable(),
      //transformer: bloc_concurrency.concurrent(),
    );
  }

  final ISearchRepository _repository;

  /// Fetch event handler
  Future<void> _fetch(
    FetchFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      emit(FavoriteState.processing(data: state.data));
      final newData = await _repository.fetchFavoriteProducts();
      emit(FavoriteState.successful(data: newData));
    } on Object catch (err, stackTrace) {
      //l.e('An error occurred in the FavoriteBLoC: $err', stackTrace);
      emit(FavoriteState.error(data: state.data));
      rethrow;
    } finally {
      emit(FavoriteState.idle(data: state.data));
    }
  }

  ///  Add Favorite Product event handler
  Future<void> _addFavoriteProduct(
    CreateFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      emit(FavoriteState.processing(data: state.data));
      await _repository.addFavoriteProduct(event.name);
      final newData = await _repository.fetchFavoriteProducts();
      emit(FavoriteState.successful(data: newData));
    } on Object catch (err, stackTrace) {
      //l.e('An error occurred in the FavoriteBLoC: $err', stackTrace);
      emit(FavoriteState.error(data: state.data));
      rethrow;
    } finally {
      emit(FavoriteState.idle(data: state.data));
    }
  }

  ///  Delete Favorite Product event handler
  Future<void> _deleteFavoriteProduct(
    DeleteFavoriteEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    try {
      emit(FavoriteState.processing(data: state.data));
      await _repository.removeFavoriteProduct(event.name);
      final newData = await _repository.fetchFavoriteProducts();

      emit(FavoriteState.successful(data: newData));
    } on Object catch (err, stackTrace) {
      //l.e('An error occurred in the FavoriteBLoC: $err', stackTrace);
      emit(FavoriteState.error(data: state.data));
      rethrow;
    } finally {
      emit(FavoriteState.idle(data: state.data));
    }
  }
}
