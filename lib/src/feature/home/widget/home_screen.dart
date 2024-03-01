import 'package:flutter/material.dart';
import 'package:sizzle_starter/src/feature/search/widget/favorite_scope.dart';
import 'package:sizzle_starter/src/feature/search/widget/favorite_screen.dart';
import 'package:sizzle_starter/src/feature/search/widget/search_scope.dart';
import 'package:sizzle_starter/src/feature/search/widget/search_screen.dart';

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
  int _tabInddex = 0;

  @override
  Widget build(BuildContext context) => SearchScope(
        child: FavoriteScope(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: SafeArea(
              child: IndexedStack(
                index: _tabInddex,
                children: const [
                  SearchScreen(),
                  FavoriteScreen(),
                ],
              ),
            ),
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                setState(() {
                  _tabInddex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                NavigationDestination(
                  icon: Icon(Icons.favorite),
                  label: 'Favorite',
                ),
              ],
            ),
          ),
        ),
      );
}
