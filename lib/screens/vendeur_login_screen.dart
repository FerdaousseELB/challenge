import 'package:challenge/screens/ventes_vendeur_screen.dart';
import 'package:flutter/material.dart';

class VendeurLoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  void _onLogin(BuildContext context) {
    String username = _usernameController.text.trim().toLowerCase();
    if (username == 'vendeur1' || username == 'vendeur2' || username == 'vendeur3') {
      // Connexion réussie en tant que vendeur
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VentesVendeurScreen(username: username),
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
      appBar: AppBar(title: Text('Connexion Vendeur')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Nom du Vendeur'),
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
