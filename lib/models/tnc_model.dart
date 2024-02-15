/*
 * *
 *  * Created by NullByte08 in 2024.
 *
 */

class TnCModel {
  int id;
  String value;
  String createdAt;
  String updatedAt;

  TnCModel({
    required this.id,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TnCModel.fromJson(Map<String, dynamic> json) {
    return TnCModel(
      id: json['id'],
      value: json['value'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
