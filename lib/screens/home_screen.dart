import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Movie App')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Movies',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    movieProvider.searchMovies(searchController.text);
                  },
                ),
              ),
              onSubmitted: (value) {
                movieProvider.searchMovies(value);
              },
            ),
          ),
          Expanded(
            child: movieProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : movieProvider.searchResults.isNotEmpty
                    ? ListView.builder(
                        itemCount: movieProvider.searchResults.length,
                        itemBuilder: (context, index) {
                          return MovieItem(
                            movie: movieProvider.searchResults[index],
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: movieProvider.popularMovies.length,
                        itemBuilder: (context, index) {
                          return MovieItem(
                            movie: movieProvider.popularMovies[index],
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
