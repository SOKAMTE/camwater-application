class Caisses {
  final int id;
  final String recette;
  final String depense;
  final String encaissement;
  final String branchement;
  final String abonnement;

  const Caisses({
    required this.id,
    required this.recette,
    required this.depense,
    required this.encaissement,
    required this.branchement,
    required this.abonnement,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recette': recette,
      'depense': depense,
      'encaissement': encaissement,
      'branchement': branchement,
      'abonnement': abonnement,
    };
  }

  factory Caisses.fromJson(Map<String, dynamic> json) {
    return Caisses(
      id: json['id'],
      recette: json['recette'],
      depense: json['depense'],
      encaissement: json['encaissement'],
      branchement: json['branchement'],
      abonnement: json['abonnement'],
    );
  }

  @override
  String toString() {
    return 'Caisses{id: $id, recette: $recette, depense: $depense, encaissement: $encaissement, branchement: $branchement, abonnement: $abonnement}';
  }
}
