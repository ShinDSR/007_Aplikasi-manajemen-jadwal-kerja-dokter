import 'dart:convert';

class PoliModel {
  String? id;
  String poliname;
  PoliModel({
    this.id,
    required this.poliname,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'poliname': poliname,
    };
  }

  factory PoliModel.fromMap(Map<String, dynamic> map) {
    return PoliModel(
      id: map['id'],
      poliname: map['poliname'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PoliModel.fromJson(String source) => PoliModel.fromMap(json.decode(source));
}
