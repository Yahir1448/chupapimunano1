import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_item.dart';
import 'details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    await prefs.remove('user_password');
    await prefs.remove('user_phone');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      extendBodyBehindAppBar:
          true, // Permite que el fondo cubra toda la pantalla
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A2A6C), // Color contrastante
        elevation: 0,
        title: const Text('Películas Populares',
            style: TextStyle(color: Colors.white)),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor:
            const Color(0xFF1A2A6C), // Color contrastante para el Drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF0F1C3D),
              ),
              child: Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle, color: Colors.white),
              title:
                  const Text('Cuenta', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                // Agrega lógica para la pantalla de cuenta si la tienes
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text('Configuración',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                // Agrega lógica para la pantalla de configuración si la tienes
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text('Cerrar Sesión',
                  style: TextStyle(color: Colors.white)),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  hintText: 'Buscar Películas',
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white70),
                    onPressed: () {
                      movieProvider.searchMovies(searchController.text);
                    },
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                onSubmitted: (value) {
                  movieProvider.searchMovies(value);
                },
              ),
            ),
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
