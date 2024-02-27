import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizzle_starter/src/core/localization/localization.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:sizzle_starter/src/feature/search/bloc/search_bloc.dart';
import 'package:sizzle_starter/src/feature/search/model/entity.dart';
import 'package:sizzle_starter/src/feature/settings/widget/settings_scope.dart';

/// {@template sample_page}
/// SamplePage widget
/// {@endtemplate}
class HomeScreen extends StatefulWidget {
  /// {@macro sample_page}
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child:

              // Column(
              //   children: <Widget>[
              //     Padding(
              //       padding: const EdgeInsets.all(25.0),
              //       child: Center(
              //         child: SizedBox(
              //           height: 100,
              //           child: TextField(
              //             onChanged: (value) {
              //               if (value.isNotEmpty && value.length > 2) {
              //                 searchDebounce?.cancel();
              //                 searchDebounce =
              //                     Timer(const Duration(milliseconds: 500), () {
              //                   searchBLoC.add(SearchEvent.fetch(name: value));
              //                   print(value);
              //                 });
              //               }
              //             },
              //           ),
              //         ),
              //       ),
              //     ),
              //     BlocBuilder<SearchBLoC, SearchState>(
              //       bloc: searchBLoC,
              //       builder: (context, state) {
              //         if (state is SearchState$Error) {
              //           return Center(child: Text(state.message));
              //         } else {
              //           return Expanded(
              //             child: ListView.builder(
              //               itemCount: state.data!.combinedData.length,
              //               itemBuilder: (context, index) {
              //                 final dataSingle = state.data!.combinedData[index];

              //                 return Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Column(
              //                     mainAxisSize: MainAxisSize.min,
              //                     children: [
              //                       Text(dataSingle.name!),
              //                       Text(
              //                         dataSingle.gender ?? dataSingle.manufacturer!,
              //                       ),
              //                       SizedBox(
              //                         height: 150,
              //                         child: ListView.builder(
              //                           scrollDirection: Axis.horizontal,
              //                           // itemExtent: 30.0,
              //                           itemCount: dataSingle.pilots == null
              //                               ? dataSingle.starships!.length
              //                               : dataSingle.pilots!.length,
              //                           itemBuilder: (context, index) {
              //                             late final List<String>? items;
              //                             if (dataSingle.pilots == null) {
              //                               items = dataSingle.starships;
              //                             } else {
              //                               items = dataSingle.pilots;
              //                             }
              //                             return SizedBox(
              //                               height: 30.0,
              //                               child: Text(items![index]),
              //                             );
              //                           },
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 );
              //               },
              //             ),
              //           );
              //         }
              //       },
              //     ),
              //   ],
              // ),
              CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Center(
                    child: SizedBox(
                      height: 100,
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
                ),
              ),
              BlocBuilder<SearchBLoC, SearchState>(
                bloc: searchBLoC,
                builder: (context, state) {
                  if (state is SearchState$Error) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text(state.message)),
                    );
                  } else if (state is SearchState$Processing) {
                    return const SliverToBoxAdapter(
                      child:
                          Center(child: CircularProgressIndicator.adaptive()),
                    );
                  } else {
                    return SliverList(
                      delegate: SliverChildListDelegate.fixed([
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemCount: state.data!.combinedData.length,
                            itemBuilder: (context, index) {
                              final dataSingle =
                                  state.data!.combinedData[index];

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(dataSingle.name!),
                                    Text(
                                      dataSingle.gender ??
                                          dataSingle.manufacturer!,
                                    ),
                                    SizedBox(
                                      height: 150,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        // itemExtent: 30.0,
                                        itemCount: dataSingle.pilots == null
                                            ? dataSingle.starships!.length
                                            : dataSingle.pilots!.length,
                                        itemBuilder: (context, index) {
                                          late final List<Object>? items;
                                          if (dataSingle.pilots == null) {
                                            items = dataSingle.starships;
                                            return SizedBox(
                                              height: 30.0,
                                              child: Text(
                                                (items! as List<StarShip>)[
                                                        index]
                                                    .name,
                                              ),
                                            );
                                          } else {
                                            items = dataSingle.pilots;
                                            return SizedBox(
                                              height: 30.0,
                                              child: Text(
                                                (items! as List<People>)[index]
                                                    .name,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ]),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
}

class _LanguagesSelector extends StatelessWidget {
  const _LanguagesSelector(this._languages);

  final List<Locale> _languages;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _languages.length,
          itemBuilder: (context, index) {
            final language = _languages.elementAt(index);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: _LanguageCard(language),
            );
          },
        ),
      );
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard(this._language);

  final Locale _language;

  @override
  Widget build(BuildContext context) => Card(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: InkWell(
            onTap: () => SettingsScope.localeOf(context).setLocale(_language),
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              width: 64,
              child: Center(
                child: Text(
                  _language.languageCode,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _ThemeSelector extends StatelessWidget {
  const _ThemeSelector(this._colors);

  final List<Color> _colors;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 30.0,
        child: ListView.builder(
          itemCount: _colors.length,
          itemBuilder: (context, index) {
            final color = _colors.elementAt(index);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: _ThemeCard(color),
            );
          },
        ),
      );
}

class _ThemeCard extends StatelessWidget {
  const _ThemeCard(this._color);

  final Color _color;

  @override
  Widget build(BuildContext context) => Card(
        child: Material(
          color: _color,
          borderRadius: BorderRadius.circular(4),
          child: InkWell(
            onTap: () {
              SettingsScope.themeOf(context).setThemeSeedColor(_color);
            },
            borderRadius: BorderRadius.circular(4),
            child: const SizedBox.square(dimension: 64),
          ),
        ),
      );
}
