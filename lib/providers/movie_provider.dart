// TODO Implement this library.
import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _popularMovies = [];
  List<Movie> _searchResults = [];
  bool _isLoading = false;

  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  final MovieService _movieService = MovieService();

  MovieProvider() {
    loadPopularMovies();
  }

  Future<void> loadPopularMovies() async {
    _isLoading = true;
    notifyListeners();
    try {
      _popularMovies = await _movieService.getPopularMovies();
    } catch (e) {
      print('Error al cargar películas populares: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      _searchResults = await _movieService.searchMovies(query);
    } catch (e) {
      print('Error al buscar películas: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}
