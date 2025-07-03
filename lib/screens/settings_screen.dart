import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _autoDownloadEnabled = false;
  bool _isNSFWEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications') ?? true;
      _autoDownloadEnabled = prefs.getBool('auto_download') ?? false;
      _isNSFWEnabled = prefs.getBool('nsfw_enabled') ?? false;
    });
  }

  Future<void> _savePreference(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
    setState(() {
      if (key == 'notifications') _notificationsEnabled = value;
      if (key == 'auto_download') _autoDownloadEnabled = value;
      if (key == 'nsfw_enabled') _isNSFWEnabled = value;
    });
  }

  void _showLanguageOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.language, color: Colors.white70),
              title:
                  const Text('Español', style: TextStyle(color: Colors.white)),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Idioma cambiado a Español')),
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.white70),
              title:
                  const Text('English', style: TextStyle(color: Colors.white)),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Language changed to English')),
                );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Configuración', onBackPressed: null),
      endDrawer: const AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: Theme.of(context).primaryColor == const Color(0xFF0A0F23)
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0A0F23), Color(0xFF141A3A)],
                )
              : const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0F1C3D), Color(0xFF1A2A6C)],
                ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.language, color: Colors.white70),
                    title: const Text('Idioma',
                        style: TextStyle(color: Colors.white)),
                    subtitle: const Text('Español',
                        style: TextStyle(color: Colors.white70)),
                    onTap: _showLanguageOptions,
                  ),
                  const Divider(color: Colors.white24, height: 1),
                  ListTile(
                    leading: const Icon(Icons.info, color: Colors.white70),
                    title: const Text('Acerca de',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Acerca de seleccionado')),
                      );
                    },
                  ),
                  const Divider(color: Colors.white24, height: 1),
                  ListTile(
                    leading: const Icon(Icons.gavel, color: Colors.white70),
                    title: const Text('Aviso Legal',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Aviso Legal seleccionado')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Notificaciones',
                        style: TextStyle(color: Colors.white)),
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      _savePreference('notifications', value);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Notificaciones ${value ? 'activadas' : 'desactivadas'}')),
                      );
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                    tileColor: Colors.transparent,
                  ),
                  const Divider(color: Colors.white24, height: 1),
                  SwitchListTile(
                    title: const Text('Reproducción y Descarga Automática',
                        style: TextStyle(color: Colors.white)),
                    value: _autoDownloadEnabled,
                    onChanged: (value) {
                      _savePreference('auto_download', value);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Descarga automática ${value ? 'activada' : 'desactivada'}')),
                      );
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                    tileColor: Colors.transparent,
                  ),
                  const Divider(color: Colors.white24, height: 1),
                  SwitchListTile(
                    title: const Text('Contenido NSFW',
                        style: TextStyle(color: Colors.white)),
                    subtitle: const Text('Activar contenido no seguro',
                        style: TextStyle(color: Colors.white70)),
                    value: _isNSFWEnabled,
                    onChanged: (value) {
                      _savePreference('nsfw_enabled', value);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Contenido NSFW ${value ? 'activado' : 'desactivado'}')),
                      );
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                    tileColor: Colors.transparent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.lock, color: Colors.white70),
                    title: const Text('Permisos',
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text(
                      'Contenido permitido: ${!_isNSFWEnabled ? 'Solo SFW' : 'SFW y NSFW'}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
