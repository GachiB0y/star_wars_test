import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sizzle_starter/src/feature/search/data/search_repo.dart';
import 'package:sizzle_starter/src/feature/search/model/entity.dart';

part 'search_bloc.freezed.dart';
part 'search_event.dart';
part 'search_state.dart';

/// Business Logic Component SearchBLoC
class SearchBLoC extends Bloc<SearchEvent, SearchState>
    implements EventSink<SearchEvent> {
  /// Business Logic Component SearchBLoC

  SearchBLoC({
    required final ISearchRepository repository,
    final SearchState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              const SearchState.idle(
                data: SearchEntity(combinedData: [], favorites: []),
                message: 'Initial idle state',
              ),
        ) {
    on<SearchEvent>(
      (event, emit) => event.map<Future<void>>(
        fetch: (event) => _fetch(event, emit),
        fetchFavorite: (event) => _fetchFavorites(event, emit),
      ),
      transformer: bloc_concurrency.sequential(),
      //transformer: bloc_concurrency.restartable(),
      //transformer: bloc_concurrency.droppable(),
      // transformer: bloc_concurrency.concurrent(),
    );
  }

  final ISearchRepository _repository;

  /// Fetch event handler
  Future<void> _fetch(FetchSearchEvent event, Emitter<SearchState> emit) async {
    try {
      emit(SearchState.processing(data: state.data));
      final List<CombinedData> newData =
          await _repository.serach(name: event.name);
      emit(
        SearchState.successful(
          data: state.data!.copyWith(combinedData: newData),
        ),
      );
    } on Object catch (err, stackTrace) {
      //l.e('An error occurred in the SearchBLoC: $err', stackTrace);
      emit(SearchState.error(data: state.data));
      rethrow;
    } finally {
      emit(SearchState.idle(data: state.data));
    }
  }

  /// Fetch event handler
  Future<void> _fetchFavorites(
    FetchFavoriteSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(SearchState.processing(data: state.data));
      final List<CombinedData> newData =
          await _repository.serachToListName(names: event.names);
      emit(
        SearchState.successful(
          data: state.data!.copyWith(favorites: newData),
        ),
      );
    } on Object catch (err, stackTrace) {
      //l.e('An error occurred in the SearchBLoC: $err', stackTrace);
      emit(SearchState.error(data: state.data));
      rethrow;
    } finally {
      emit(SearchState.idle(data: state.data));
    }
  }
}
