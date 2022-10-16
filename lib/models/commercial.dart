class Commercials {
  final int id;
  final String devis_branchement;
  final String abonnement;
  final String fiche_poste;
  final String depose_compteur;
  final String rapport_activite;

  const Commercials({
    required this.id,
    required this.devis_branchement,
    required this.abonnement,
    required this.fiche_poste,
    required this.depose_compteur,
    required this.rapport_activite,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'devis_branchement': devis_branchement,
      'abonnement': abonnement,
      'fiche_poste': fiche_poste,
      'depose_compteur': depose_compteur,
      'rapport_activite': rapport_activite,
    };
  }

  factory Commercials.fromJson(Map<String, dynamic> json) {
    return Commercials(
      id: json['id'],
      devis_branchement: json['devis_branchement'],
      abonnement: json['abonnement'],
      fiche_poste: json['fiche_poste'],
      depose_compteur: json['depose_compteur'],
      rapport_activite: json['rapport_activite'],
    );
  }

  @override
  String toString() {
    return 'Commercials{id: $id, devis_branchement: $devis_branchement, abonnement: $abonnement, fiche_poste: $fiche_poste, depose_compteur: $depose_compteur, rapport_activite: $rapport_activite}';
  }
}
