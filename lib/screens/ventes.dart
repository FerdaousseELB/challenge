import 'package:flutter/material.dart';
import '../main.dart'; // Importez le fichier main.dart pour accéder à la page d'accueil

class VentesScreen extends StatelessWidget {
  final String username;
  final List<String> produits = ['produit1', 'produit2', 'produit3', 'produit4', 'produit5'];
  final Map<String, Map<String, int>> ventes = {
    'produit1': {'vendeur1': 0, 'vendeur2': 0, 'vendeur3': 0},
    'produit2': {'vendeur1': 0, 'vendeur2': 0, 'vendeur3': 0},
    'produit3': {'vendeur1': 0, 'vendeur2': 0, 'vendeur3': 0},
    'produit4': {'vendeur1': 0, 'vendeur2': 0, 'vendeur3': 0},
    'produit5': {'vendeur1': 0, 'vendeur2': 0, 'vendeur3': 0},
  };

  VentesScreen({required this.username});

  void _onLogout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyApp()), // Retour à la page d'accueil (main.dart)
          (route) => false, // Supprime toutes les routes de la pile de navigation
    );
  }

  void _incrementVentes(String produit, String vendeur) {
    if (ventes.containsKey(produit) && ventes[produit]!.containsKey(vendeur)) {
      ventes[produit]![vendeur] = ventes[produit]![vendeur]! + 1;
    }
  }

  void _decrementVentes(String produit, String vendeur) {
    if (ventes.containsKey(produit) && ventes[produit]![vendeur]! > 0) {
      ventes[produit]![vendeur] = ventes[produit]![vendeur]! - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('les Ventes'),
        automaticallyImplyLeading: false, // Masque la flèche de retour
        actions: [
          // Affiche le nom d'utilisateur en haut à droite de l'app Bar
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(child: Text('$username')),
          ),
          // Bouton de déconnexion
          IconButton(
            onPressed: () => _onLogout(context),
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Vendeur')),
              for (var produit in produits)
                DataColumn(label: Text(produit)),
            ],
            rows: [
              for (var vendeur in ventes.values.first.keys)
                DataRow(cells: [
                  DataCell(Text(vendeur)),
                  for (var produit in produits)
                    DataCell(
                      Column(
                        children: [
                          Text(
                            ventes[produit]?.containsKey(vendeur) == true
                                ? ventes[produit]![vendeur].toString()
                                : '0',
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  _decrementVentes(produit, vendeur);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  _incrementVentes(produit, vendeur);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ]),
            ],
          ),
        ),
      ),
    );
  }
}
