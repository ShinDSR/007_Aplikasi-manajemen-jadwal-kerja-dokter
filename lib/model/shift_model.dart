import 'dart:convert';

class ShiftModel {
  String? id;
  String shiftname;
  String timein;
  String timeout;
  ShiftModel({
    this.id,
    required this.shiftname,
    required this.timein,
    required this.timeout,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shiftname': shiftname,
      'timein': timein,
      'timeout': timeout,
    };
  }

  factory ShiftModel.fromMap(Map<String, dynamic> map) {
    return ShiftModel(
      id: map['id'],
      shiftname: map['shiftname'] ?? '',
      timein: map['timein'] ?? '',
      timeout: map['timeout'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ShiftModel.fromJson(String source) => ShiftModel.fromMap(json.decode(source));
}
 