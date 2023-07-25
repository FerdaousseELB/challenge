
class ProduitModel {
  final List<String> produits;

  ProduitModel(this.produits);

  static Future<ProduitModel> getProduits() async {
    await Future.delayed(Duration(seconds: 1)); // Ajout d'un délai de 1 seconde pour simuler une requête asynchrone

    List<String> produits = ['produit1', 'produit2', 'produit3', 'produit4', 'produit5'];

    return ProduitModel(produits);
  }
}
