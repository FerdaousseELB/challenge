import 'package:flutter/material.dart';
import 'screens/vendeur_login_screen.dart';
import 'screens/gerant_login_screen.dart';
import 'screens/ventes_gerant_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Boutique Compléments Alimentaires',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/vendeur_login': (context) => VendeurLoginScreen(),
        '/gerant_login': (context) => GerantLoginScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accueil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/vendeur_login');
              },
              child: Text('Se Connecter en tant que Vendeur'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/gerant_login');
              },
              child: Text('Se Connecter en tant que Gérant'),
            ),
          ],
        ),
      ),
    );
  }
}
