import 'package:flutter/material.dart';
import 'ventes_gerant_screen.dart';

class GerantLoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  void _onLogin(BuildContext context) {
    String username = _usernameController.text.trim().toLowerCase();
    if (username == 'gerant') {
      // Connexion réussie en tant que gérant
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VentesGerantScreen(username: 'gerant'),
        ),
      );
    } else {
      // Login incorrect
      _showLoginError(context);
    }
  }

  void _showLoginError(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Erreur de Connexion'),
        content: Text('Le login n\'est pas correct. Veuillez réessayer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connexion Gérant')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Nom du Gérant'),
              ),
            ),
            ElevatedButton(
              onPressed: () => _onLogin(context),
              child: Text('Se Connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
