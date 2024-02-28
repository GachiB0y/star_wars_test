import 'package:flutter/material.dart';
import 'package:sizzle_starter/src/feature/search/widget/favorite_scope.dart';
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
  @override
  Widget build(BuildContext context) => FavoriteScope(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: const SafeArea(
            child: SearchScreen(),
          ),
        ),
      );
}
