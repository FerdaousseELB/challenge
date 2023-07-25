import 'package:flutter/material.dart';
import '../main.dart';

const List<String> produits = ['produit1', 'produit2', 'produit3', 'produit4', 'produit5'];

const List<String> vendeurs = ['vendeur1', 'vendeur2', 'vendeur3'];

class Vente {
  final String produit;
  final Map<String, int> ventes;

  Vente(this.produit, this.ventes);
}

class VentesVendeurScreen extends StatefulWidget {
  final String username;

  VentesVendeurScreen({required this.username});

  @override
  _VentesVendeurScreenState createState() => _VentesVendeurScreenState();
}

class _VentesVendeurScreenState extends State<VentesVendeurScreen> {
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
      MaterialPageRoute(builder: (context) => MyApp()),
          (route) => false,
    );
  }

  void _updateVentes(String produit, int value) {
    setState(() {
      ventes[produit]![widget.username] = value < 0 ? 0 : value;
    });
  }


  Color getBackgroundColor(String produit) {
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

  List<Vente> getVentesList() {
    return produits.map((produit) => Vente(produit, ventes[produit]!)).toList();
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
                for (var vendeur in vendeurs)
                  if (vendeur != widget.username) DataColumn(label: Text('$vendeur')),
              ],
              rows: [
                for (var vente in getVentesList())
                  DataRow(
                    cells: [
                      DataCell(Text(vente.produit)),
                      DataCell(
                        Container(
                          color: getBackgroundColor(vente.produit),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  _updateVentes(vente.produit, (ventes[vente.produit]![widget.username] ?? 0) - 1);
                                },
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    ventes[vente.produit]![widget.username]?.toString() ?? '0',
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  _updateVentes(vente.produit, (ventes[vente.produit]![widget.username] ?? 0) + 1);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      for (var vendeur in vendeurs)
                        if (vendeur != widget.username)
                          DataCell(
                            Center(
                              child: Text(
                                vente.ventes[vendeur].toString(),
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