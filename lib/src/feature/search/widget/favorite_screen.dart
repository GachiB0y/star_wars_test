import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:sizzle_starter/src/feature/search/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:sizzle_starter/src/feature/search/bloc/search_bloc/search_bloc.dart';
import 'package:sizzle_starter/src/feature/search/model/entity.dart';
import 'package:sizzle_starter/src/feature/search/widget/favorite_button.dart';
import 'package:sizzle_starter/src/feature/search/widget/favorite_scope.dart';
import 'package:sizzle_starter/src/feature/search/widget/search_scope.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late final FavoriteBLoC _favoriteBLoC;
  late final SearchBLoC _searchBLoC;
  late Set<String> favorites;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _favoriteBLoC = FavoriteScope.of(context).state.favoriteBLoC;
    favorites = _favoriteBLoC.state.data ?? <String>{};

    _searchBLoC = SearchScope.of(context).state.searchBLoC
      ..add(SearchEvent.fetchFavorite(names: favorites.toList()));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocListener<FavoriteBLoC, FavoriteState>(
          bloc: _favoriteBLoC,
          listener: (context, state) {
            if (state is FavoriteState$Successful) {
              if (state.data!.isNotEmpty) {
                _searchBLoC.add(
                  SearchEvent.fetchFavorite(names: state.data!.toList()),
                );
              }
            }
          },
          child: BlocBuilder<SearchBLoC, SearchState>(
            bloc: _searchBLoC,
            builder: (context, state) => CustomScrollView(
              slivers: [
                if (state.data == null || state.data!.favorites.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text('Favorites is empty'),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    sliver: FavoriteItemsGridWidget(
                      products: state.data!.favorites,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
}

class FavoriteItemsGridWidget extends StatelessWidget {
  const FavoriteItemsGridWidget({required this.products, super.key});

  final List<CombinedData> products;

  @override
  Widget build(BuildContext context) => SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 152,
          //mainAxisExtent: 180,
          childAspectRatio: 152 / 180,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
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
                  productId: product.name!,
                ),
                Text('Имя:${product.name!}'),
                Text(
                  product.gender != null
                      ? 'Пол:${product.gender}'
                      : 'Производитель:${product.manufacturer}',
                ),
                Text(
                  product.passengers != null
                      ? 'Пассажиры:${product.passengers}'
                      : 'Кол-во кораблей:${product.starships?.length}',
                ),
              ],
            ),
          );
        },
      );
}
