import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey =
      '413fc743042d3f59547df08915b0f7c0'; // Reemplazado con tu API Key

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } else {
      throw Exception('No se pudieron cargar las películas populares');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$query'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((json) => Movie.fromJson(json))
          .toList();
    } else {
      throw Exception('No se pudieron cargar los resultados de búsqueda');
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/$movieId?api_key=$_apiKey'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Exception('No se pudieron cargar los detalles de la película');
    }
  }
}
