import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_item.dart';
import 'details_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Películas Populares',
        searchController: searchController,
        onSearchSubmitted: () {
          movieProvider.searchMovies(searchController.text);
        },
      ),
      endDrawer: const AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F1C3D), Color(0xFF1A2A6C)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: movieProvider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white))
                  : Container(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: movieProvider.searchResults.isNotEmpty
                            ? movieProvider.searchResults.length
                            : movieProvider.popularMovies.length,
                        itemBuilder: (context, index) {
                          final movie = movieProvider.searchResults.isNotEmpty
                              ? movieProvider.searchResults[index]
                              : movieProvider.popularMovies[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsScreen(movie: movie),
                                ),
                              );
                            },
                            child: MovieItem(movie: movie),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
