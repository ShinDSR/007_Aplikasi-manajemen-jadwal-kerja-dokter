import 'dart:convert';

class JadwalModel {
  String? id;
  String day;
  String shiftname;
  String name;
  JadwalModel({
    this.id,
    required this.day,
    required this.shiftname,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'day': day,
      'shiftname': shiftname,
      'name': name,
    };
  }

  factory JadwalModel.fromMap(Map<String, dynamic> map) {
    return JadwalModel(
      id: map['id'],
      day: map['day'] ?? '',
      shiftname: map['shiftname'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory JadwalModel.fromJson(String source) => JadwalModel.fromMap(json.decode(source));
}
