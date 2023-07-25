import 'package:flutter/material.dart';
import '../main.dart'; // Importez le fichier main.dart pour accéder à la page d'accueil

class VentesVendeurScreen extends StatefulWidget {
  final String username;

  VentesVendeurScreen({required this.username});

  @override
  _VentesVendeurScreenState createState() => _VentesVendeurScreenState();
}

class _VentesVendeurScreenState extends State<VentesVendeurScreen> {
  final List<String> produits = ['produit1', 'produit2', 'produit3', 'produit4', 'produit5'];
  final Map<String, Map<String, int>> ventes = {
    'produit1': {'vendeur1': 5, 'vendeur2': 0, 'vendeur3': 0},
    'produit2': {'vendeur1': 0, 'vendeur2': 0, 'vendeur3': 0},
    'produit3': {'vendeur1': 0, 'vendeur2': 2, 'vendeur3': 0},
    'produit4': {'vendeur1': 2, 'vendeur2': 3, 'vendeur3': 0},
    'produit5': {'vendeur1': 0, 'vendeur2': 0, 'vendeur3': 0},
  };

  void _onLogout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyApp()), // Retour à la page d'accueil (main.dart)
          (route) => false, // Supprime toutes les routes de la pile de navigation
    );
  }

  void _incrementVentes(String produit) {
    setState(() {
      ventes[produit]![widget.username] = (ventes[produit]![widget.username] ?? 0) + 1;
    });
  }

  void _decrementVentes(String produit) {
    setState(() {
      if (ventes[produit]![widget.username] != null && ventes[produit]![widget.username]! > 0) {
        ventes[produit]![widget.username] = ventes[produit]![widget.username]! - 1;
      }
    });
  }

  Color getBackgroundColor(String produit, String vendeur) {
    int myVentes = ventes[produit]![widget.username] ?? 0;
    List<int> ventesList = ventes[produit]!.values.toList();
    ventesList.remove(ventes[produit]![widget.username]);

    if (myVentes > ventesList.reduce((a, b) => a > b ? a : b)) {
      return Colors.green;
    } else if (myVentes < ventesList.reduce((a, b) => a < b ? a : b)) {
      return Colors.red;
    } else {
      return Colors.orange;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Ventes'),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(child: Text('${widget.username}')),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 32.0,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Produit')),
                DataColumn(label: Text('Ventes')),
                for (var vendeur in ventes.values.first.keys)
                  if (vendeur != widget.username) DataColumn(label: Text('$vendeur')),
              ],
              rows: [
                for (var produit in produits)
                  DataRow(
                    cells: [
                      DataCell(Text(produit)),
                      DataCell(
                        Container(
                          color: getBackgroundColor(produit, widget.username),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  _decrementVentes(produit);
                                },
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    ventes[produit]![widget.username]?.toString() ?? '0',
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  _incrementVentes(produit);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      for (var vendeur in ventes[produit]!.keys)
                        if (vendeur != widget.username)
                          DataCell(
                            Center(
                              child: Text(
                                ventes[produit]![vendeur].toString(),
                              ),
                            ),
                          ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}