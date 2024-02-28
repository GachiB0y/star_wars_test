import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:sizzle_starter/src/feature/search/bloc/search_bloc/search_bloc.dart';
import 'package:sizzle_starter/src/feature/search/widget/favorite_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Timer? searchDebounce;

  late final SearchBLoC searchBLoC;

  @override
  void initState() {
    super.initState();
    searchBLoC = SearchBLoC(
      repository: DependenciesScope.of(context).searchRepository,
    );
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Center(
              child: SizedBox(
                // height: 200,
                child: TextField(
                  onChanged: (value) {
                    if (value.isNotEmpty && value.length > 2) {
                      searchDebounce?.cancel();
                      searchDebounce =
                          Timer(const Duration(milliseconds: 500), () {
                        searchBLoC.add(SearchEvent.fetch(name: value));
                        print(value);
                      });
                    }
                  },
                ),
              ),
            ),
            pinned: true,
            floating: true,
            snap: true,
          ),
          ScrolContentWidget(searchBLoC: searchBLoC),
        ],
      );
}

/// {@template sample_page}
/// SamplePage widget
/// {@endtemplate}
class ScrolContentWidget extends StatelessWidget {
  /// {@macro sample_page}
  const ScrolContentWidget({
    required this.searchBLoC,
    super.key,
  });

  final SearchBLoC searchBLoC;

  @override
  Widget build(BuildContext context) => BlocBuilder<SearchBLoC, SearchState>(
        bloc: searchBLoC,
        builder: (context, state) {
          if (state is SearchState$Error) {
            return SliverToBoxAdapter(
              child: Center(child: Text(state.message)),
            );
          } else if (state is SearchState$Processing) {
            return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator.adaptive()),
            );
          } else {
            return SliverList(
              delegate: SliverChildListDelegate([
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.data!.combinedData.length,
                  itemBuilder: (context, index) {
                    final dataSingle = state.data!.combinedData[index];

                    return SizedBox(
                      height: 150,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        color: Theme.of(context).cardColor,
                        margin: const EdgeInsets.all(14),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FavoriteButtonWidget(
                              productId: dataSingle.name!,
                            ),
                            Text('Имя:${dataSingle.name!}'),
                            Text(
                              dataSingle.gender != null
                                  ? 'Пол:${dataSingle.gender}'
                                  : 'Производитель:${dataSingle.manufacturer}',
                            ),

                            Text(
                              dataSingle.passengers != null
                                  ? 'Пассажиры:${dataSingle.passengers}'
                                  : 'Кол-во кораблей:${dataSingle.starships?.length}',
                            ),

                            // SizedBox(
                            //   height: 150,
                            //   child: ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     // itemExtent: 30.0,
                            //     itemCount: dataSingle.pilots == null
                            //         ? dataSingle.starships!.length
                            //         : dataSingle.pilots!.length,
                            //     itemBuilder: (context, index) {
                            //       late final List<Object>? items;
                            //       if (dataSingle.pilots == null) {
                            //         items = dataSingle.starships;
                            //         return SizedBox(
                            //           height: 30.0,
                            //           child: Text(
                            //             (items! as List<StarShip>)[
                            //                     index]
                            //                 .name,
                            //           ),
                            //         );
                            //       } else {
                            //         items = dataSingle.pilots;
                            //         return SizedBox(
                            //           height: 30.0,
                            //           child: Text(
                            //             (items! as List<People>)[index]
                            //                 .name,
                            //           ),
                            //         );
                            //       }
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ]),
            );
          }
        },
      );
}
