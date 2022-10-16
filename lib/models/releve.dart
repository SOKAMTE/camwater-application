class Releves {
  final int id;
  final String nom_agence;
  final String code_agence;
  final String nom_releveur;
  final String numero_compteur;
  final String nom_prenom;
  final String reference_abonne;
  final String ancien_index;
  final String nouvel_index;
  final String anomalie;
  final String photo;

  const Releves({
    required this.id,
    required this.nom_agence,
    required this.code_agence,
    required this.nom_releveur,
    required this.numero_compteur,
    required this.nom_prenom,
    required this.reference_abonne,
    required this.ancien_index,
    required this.nouvel_index,
    required this.anomalie,
    required this.photo,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom_agence': nom_agence,
      'code_agence': code_agence,
      'nom_releveur': nom_releveur,
      'numero_compteur': numero_compteur,
      'nom_prenom': nom_prenom,
      'reference_abonne': reference_abonne,
      'ancien_index': ancien_index,
      'nouvel_index': nouvel_index,
      'anomalie': anomalie,
      'photo': photo,
    };
  }

  factory Releves.fromJson(Map<String, dynamic> json) {
    return Releves(
      id: json['id'],
      nom_agence: json['nom_agence'],
      code_agence: json['code_agence'],
      nom_releveur: json['nom_releveur'],
      numero_compteur: json['numero_compteur'],
      nom_prenom: json['nom_prenom'],
      reference_abonne: json['reference_abonne'],
      ancien_index: json['ancien_index'],
      nouvel_index: json['nouvel_index'],
      anomalie: json['anomalie'],
      photo: json['photo'],
    );
  }

  @override
  String toString() {
    return 'Releves{id: $id, nom_agence: $nom_agence, code_agence: $code_agence, nom_releveur: $nom_releveur, numero_compteur: $numero_compteur, nom_prenom: $nom_prenom, reference_abonne: $reference_abonne, ancien_index: $ancien_index, nouvel_index: $nouvel_index, anomalie: $anomalie, photo: $photo}';
  }
}
