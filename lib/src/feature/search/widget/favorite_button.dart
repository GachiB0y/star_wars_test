import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizzle_starter/src/feature/search/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:sizzle_starter/src/feature/search/model/entity.dart';
import 'package:sizzle_starter/src/feature/search/widget/favorite_scope.dart';

class FavoriteButtonWidget extends StatefulWidget {
  const FavoriteButtonWidget({required this.productId, super.key});

  final ProductID productId;

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  late final FavoriteBLoC favoriteBLoC;

  @override
  void didChangeDependencies() {
    favoriteBLoC = FavoriteScope.of(context).state.favoriteBLoC;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<FavoriteBLoC, FavoriteState>(
        bloc: favoriteBLoC,
        builder: (context, state) {
          final bool status = state.data?.contains(widget.productId) ?? false;
          return Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                if (status) {
                  FavoriteScope.of(context)
                      .state
                      .removeFavorite(widget.productId);
                } else {
                  FavoriteScope.of(context).state.addFavorite(widget.productId);
                }
              },
              icon: Icon(
                Icons.favorite_border,
                color: status ? Colors.red : null,
              ),
            ),
          );
        },
      );
}
