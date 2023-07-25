import 'package:flutter/material.dart';
import '../main.dart'; // Importez le fichier main.dart pour accéder à la page d'accueil

class VentesGerantScreen extends StatefulWidget {
  final String username;

  VentesGerantScreen({required this.username});

  @override
  _VentesGerantScreenState createState() => _VentesGerantScreenState();
}

class _VentesGerantScreenState extends State<VentesGerantScreen> {
  final List<String> produits = ['produit1', 'produit2', 'produit3', 'produit4', 'produit5'];

  final Map<String, Map<String, int>> ventes = {
    'produit1': {'vendeur1': 0, 'vendeur2': 0, 'vendeur3': 0},
    'produit2': {'vendeur1': 0, 'vendeur2': 0, 'vendeur3': 0},
    'produit3': {'vendeur1': 0, 'vendeur2': 0, 'vendeur3': 0},
    'produit4': {'vendeur1': 0, 'vendeur2': 0, 'vendeur3': 0},
    'produit5': {'vendeur1': 0, 'vendeur2': 0, 'vendeur3': 0},
  };

  void _onLogout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyApp()), // Retour à la page d'accueil (main.dart)
          (route) => false, // Supprime toutes les routes de la pile de navigation
    );
  }

  void _incrementVentes(String produit, String vendeur) {
    if (ventes.containsKey(produit) && ventes[produit]!.containsKey(vendeur)) {
      setState(() {
        ventes[produit]![vendeur] = ventes[produit]![vendeur]! + 1;
      });
    }
  }

  void _decrementVentes(String produit, String vendeur) {
    if (ventes.containsKey(produit) && ventes[produit]![vendeur]! > 0) {
      setState(() {
        ventes[produit]![vendeur] = ventes[produit]![vendeur]! - 1;
      });
    }
  }

  Map<String, int> calculateTotalForVendeur(String vendeur) {
    Map<String, int> totalForVendeur = {};
    for (var produit in produits) {
      totalForVendeur[produit] = ventes[produit]![vendeur]!;
    }
    return totalForVendeur;
  }

  Map<String, int> calculateTotalForAllVendeurs() {
    Map<String, int> totalForAllVendeurs = {};
    for (var vendeur in ventes.values.first.keys) {
      totalForAllVendeurs[vendeur] = ventes.values
          .map<int>((vente) => vente[vendeur]!)
          .reduce((value, element) => value + element);
    }
    return totalForAllVendeurs;
  }

  List<String> getSortedVendeursByTotal() {
    // Obtenir les totaux pour chaque vendeur
    Map<String, int> totalForAllVendeurs = calculateTotalForAllVendeurs();

    // Trier les vendeurs en fonction du total des ventes dans l'ordre décroissant
    List<String> sortedVendeurs = totalForAllVendeurs.keys.toList()
      ..sort((a, b) => totalForAllVendeurs[b]!.compareTo(totalForAllVendeurs[a]!));

    return sortedVendeurs;
  }

  @override
  Widget build(BuildContext context) {
    List<String> sortedVendeurs = getSortedVendeursByTotal();
    return Scaffold(
      appBar: AppBar(
        title: Text('les Ventes'),
        automaticallyImplyLeading: false, // Masque la flèche de retour
        actions: [
          // Affiche le nom d'utilisateur en haut à droite de l'app Bar
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(child: Text('${widget.username}')),
          ),
          // Bouton de déconnexion
          IconButton(
            onPressed: () => _onLogout(context),
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 32.0, // Largeur fixe du DataTable
            child: DataTable(
              columns: [
                DataColumn(label: Text('Vendeur')),
                for (var produit in produits) DataColumn(label: Text(produit)),
                DataColumn(label: Text('Total')), // Nouvelle colonne pour le total
              ],
              rows: [
                for (var vendeur in sortedVendeurs) // Utiliser l'ordre trié des vendeurs
                  DataRow(cells: [
                    DataCell(Text(vendeur)),
                    for (var produit in produits)
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                _decrementVentes(produit, vendeur);
                              },
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  ventes[produit]?.containsKey(vendeur) == true
                                      ? ventes[produit]![vendeur].toString()
                                      : '0',
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                _incrementVentes(produit, vendeur);
                              },
                            ),
                          ],
                        ),
                      ),
                    DataCell(
                      Text(calculateTotalForVendeur(vendeur)
                          .values
                          .reduce((value, element) => value + element)
                          .toString()),
                    ), // Afficher le total pour chaque vendeur
                  ]),
                // Ligne supplémentaire pour le total de l'ensemble des ventes
                DataRow(cells: [
                  DataCell(Text('Total')),
                  for (var _ in produits) DataCell(Text('')), // Cellule vide pour les vendeurs
                  DataCell(
                    Text(ventes.values
                        .map<int>((vente) => vente.values.reduce((value, element) => value + element))
                        .reduce((value, element) => value + element)
                        .toString()),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}