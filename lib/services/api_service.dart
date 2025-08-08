import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie/models/movie.dart';
import 'package:movie/models/actor.dart';
import 'package:movie/models/movie_details.dart';

class ApiService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = '1102f57a8a767306fe5f919df189bb7b'; // Replace with your actual API key

  // Get trending movies
  static Future<List<Movie>> getTrendingMovies() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/trending/movie/week?api_key=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load trending movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get popular movies
  static Future<List<Movie>> getPopularMovies() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load popular movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Search movies
  static Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=${Uri.encodeComponent(query)}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get movie details
  static Future<MovieDetails> getMovieDetails(int movieId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/movie/$movieId?api_key=$_apiKey&append_to_response=credits'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return MovieDetails.fromJson(data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get actor details
  static Future<Actor> getActorDetails(int actorId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/person/$actorId?api_key=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Actor.fromJson(data);
      } else {
        throw Exception('Failed to load actor details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get actor's movies
  static Future<List<Movie>> getActorMovies(int actorId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/person/$actorId/movie_credits?api_key=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['cast'] as List;
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load actor movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
