import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:sizzle_starter/src/feature/search/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:sizzle_starter/src/feature/search/model/entity.dart';

/// {@template favorite_scope_controller}
/// A controller that holds and operates the FavoriteScope.
/// {@endtemplate}
abstract interface class FavoriteController {
  /// Get Favorite.
  Set<ProductID> fetchFavorite();

  /// Add Favorite.
  void addFavorite(ProductID id);

  /// Remove Favorite.
  void removeFavorite(ProductID id);

  /// Check Favorite.
  bool isFavorite(ProductID id);
}

/// {@template favorite_scope}
/// FavoriteScope widget.
/// {@endtemplate}
class FavoriteScope extends StatefulWidget {
  /// {@macro favorite_scope}
  const FavoriteScope({
    required this.child,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  static _InheritedFavoriteScope of(
    BuildContext context, {
    bool listen = true,
  }) =>
      _InheritedFavoriteScope.of(context, listen: listen);

  @override
  State<FavoriteScope> createState() => _FavoriteScopeState();
}

/// State for widget FavoriteScope.
class _FavoriteScopeState extends State<FavoriteScope>
    implements FavoriteController {
  late final FavoriteBLoC favoriteBLoC;

  Set<ProductID> _favorites = <ProductID>{};
  // bool isFavoriteBool = false;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    favoriteBLoC = FavoriteBLoC(
      repository: DependenciesScope.of(context).searchRepository,
    );
    // Initial state initialization
  }

  @override
  void didUpdateWidget(FavoriteScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }

  /* #endregion */

  @override
  Widget build(BuildContext context) => _InheritedFavoriteScope(
        state: this,
        child: widget.child,
      );

  @override
  void addFavorite(ProductID id) {
    favoriteBLoC.add(FavoriteEvent.create(name: id));
    setState(() {
      _favorites = favoriteBLoC.state.data!;
    });
  }

  @override
  Set<ProductID> fetchFavorite() {
    favoriteBLoC.add(const FavoriteEvent.fetch());
    setState(() {
      _favorites = favoriteBLoC.state.data ?? <ProductID>{};
    });
    return _favorites;
  }

  @override
  bool isFavorite(ProductID id) => _favorites.contains(id);

  @override
  void removeFavorite(ProductID id) {
    favoriteBLoC.add(FavoriteEvent.delete(name: id));
    setState(() {
      _favorites = favoriteBLoC.state.data ?? <ProductID>{};
    });
  }
}

/// Inherited widget for quick access in the element tree.
class _InheritedFavoriteScope extends InheritedWidget {
  const _InheritedFavoriteScope({
    required this.state,
    required super.child,
  });

  final _FavoriteScopeState state;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// For example: `FavoriteScope.maybeOf(context)`.
  static _InheritedFavoriteScope? maybeOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      listen
          ? context
              .dependOnInheritedWidgetOfExactType<_InheritedFavoriteScope>()
          : context
              .getElementForInheritedWidgetOfExactType<
                  _InheritedFavoriteScope>()
              ?.widget as _InheritedFavoriteScope?;

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a _InheritedFavoriteScope of the exact type',
        'out_of_scope',
      );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// For example: `FavoriteScope.of(context)`.
  static _InheritedFavoriteScope of(
    BuildContext context, {
    bool listen = true,
  }) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(covariant _InheritedFavoriteScope oldWidget) =>
      !identical(state, oldWidget.state) ||
      !setEquals(state._favorites, oldWidget.state._favorites) ||
      state != oldWidget.state;
}
