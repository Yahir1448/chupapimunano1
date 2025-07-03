import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _popularMovies = [];
  List<Movie> _searchResults = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final MovieService _movieService = MovieService();

  MovieProvider() {
    loadPopularMovies();
  }

  Future<void> loadPopularMovies() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _popularMovies = await _movieService.getPopularMovies();
    } catch (e) {
      _errorMessage = 'Error al cargar películas populares: $e';
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      _errorMessage = null;
      notifyListeners();
      return;
    }
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _searchResults = await _movieService.searchMovies(query);
    } catch (e) {
      _errorMessage = 'Error al buscar películas: $e';
    }
    _isLoading = false;
    notifyListeners();
  }
}
