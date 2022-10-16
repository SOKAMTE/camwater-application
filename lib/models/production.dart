class Productions {
  final int id;
  final String eau_brute;
  final String eau_traite;
  final String pompe_lavage;
  final String horaire_agitateur;
  final String horaire_pompe_doseuse;
  final String horaire_pompe_refoulement;
  final String stock_produit;
  final String index_eneo;

  const Productions({
    required this.id,
    required this.eau_brute,
    required this.eau_traite,
    required this.pompe_lavage,
    required this.horaire_agitateur,
    required this.horaire_pompe_doseuse,
    required this.horaire_pompe_refoulement,
    required this.stock_produit,
    required this.index_eneo,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eau_brute': eau_brute,
      'eau_traite': eau_traite,
      'pompe_lavage': pompe_lavage,
      'horaire_agitateur': horaire_agitateur,
      'horaire_pompe_doseuse': horaire_pompe_doseuse,
      'horaire_pompe_refoulement': horaire_pompe_refoulement,
      'stock_produit': stock_produit,
      'index_eneo': index_eneo,
    };
  }

  factory Productions.fromJson(Map<String, dynamic> json) {
    return Productions(
      id: json['id'],
      eau_brute: json['eau_brute'],
      eau_traite: json['eau_traite'],
      pompe_lavage: json['pompe_lavage'],
      horaire_agitateur: json['horaire_agitateur'],
      horaire_pompe_doseuse: json['horaire_pompe_doseuse'],
      horaire_pompe_refoulement: json['horaire_pompe_refoulement'],
      stock_produit: json['stock_produit'],
      index_eneo: json['index_eneo'],
    );
  }

  @override
  String toString() {
    return 'Productions{id: $id, eau_brute: $eau_brute, eau_traite: $eau_traite, pompe_lavage: $pompe_lavage, horaire_agitateur: $horaire_agitateur, horaire_pompe_doseuse: $horaire_pompe_doseuse, horaire_pompe_refoulement: $horaire_pompe_refoulement, stock_produit: $stock_produit, index_eneo: $index_eneo}';
  }
}
