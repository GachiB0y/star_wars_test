import 'package:flutter/widgets.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:sizzle_starter/src/feature/search/bloc/search_bloc/search_bloc.dart';

/// {@template search_scope}
/// SearchScope widget.
/// {@endtemplate}
class SearchScope extends StatefulWidget {
  /// {@macro search_scope}
  const SearchScope({
    required this.child,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  static _InheritedSearchScope of(BuildContext context, {bool listen = true}) =>
      _InheritedSearchScope.of(context, listen: listen);

  @override
  State<SearchScope> createState() => _SearchScopeState();
}

/// State for widget SearchScope.
class _SearchScopeState extends State<SearchScope> {
  /* #region Lifecycle */

  late final SearchBLoC searchBLoC;
  @override
  void initState() {
    super.initState();
    searchBLoC = SearchBLoC(
      repository: DependenciesScope.of(context).searchRepository,
    );
  }

  @override
  void didUpdateWidget(SearchScope oldWidget) {
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
  Widget build(BuildContext context) => _InheritedSearchScope(
        state: this,
        child: widget.child,
      );
}

/// Inherited widget for quick access in the element tree.
class _InheritedSearchScope extends InheritedWidget {
  const _InheritedSearchScope({
    required this.state,
    required super.child,
  });

  final _SearchScopeState state;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// For example: `SearchScope.maybeOf(context)`.
  static _InheritedSearchScope? maybeOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<_InheritedSearchScope>()
          : context
              .getElementForInheritedWidgetOfExactType<_InheritedSearchScope>()
              ?.widget as _InheritedSearchScope?;

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a _InheritedSearchScope of the exact type',
        'out_of_scope',
      );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// For example: `SearchScope.of(context)`.
  static _InheritedSearchScope of(BuildContext context, {bool listen = true}) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(covariant _InheritedSearchScope oldWidget) =>
      !identical(state, oldWidget.state);
}
